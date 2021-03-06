;;; core-auto-completion.el --- Spacemacs Core File
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; Company -------------------------------------------------------------------

(defvar spacemacs-default-company-backends
  '((company-dabbrev-code company-gtags company-etags company-keywords)
    company-files company-dabbrev)
  "The list of default company backends used by spacemacs.
This variable is used to configure mode-specific company backends in spacemacs.
Backends in this list will always be active in these modes, as well as any
backends added by individual spacemacs layers.")

(defmacro spacemacs|defvar-company-backends (mode)
  "Define a MODE specific company backend variable with default backends.
The variable name format is company-backends-MODE."
  `(defvar ,(intern (format "company-backends-%S" mode))
     ',spacemacs-default-company-backends
     ,(format "Company backend list for %S" mode)))

(defmacro spacemacs|add-company-hook (mode)
  "Enable company for the given MODE.
MODE must match the symbol passed in `spacemacs|defvar-company-backends'.
The initialization function is hooked to `MODE-hook'."
  (let ((mode-hook (intern (format "%S-hook" mode)))
        (func (intern (format "spacemacs//init-company-%S" mode)))
        (backend-list (intern (format "company-backends-%S" mode))))
    `(when (configuration-layer/package-usedp 'company)
       (defun ,func ()
         ,(format "Initialize company for %S" mode)
         (when auto-completion-enable-snippets-in-popup
           (setq ,backend-list (mapcar 'spacemacs//show-snippets-in-company
                                       ,backend-list)))
         (set (make-variable-buffer-local 'auto-completion-front-end)
              'company)
         (set (make-variable-buffer-local 'company-backends)
              ,backend-list))
       (add-hook ',mode-hook ',func t)
       (add-hook ',mode-hook 'company-mode t))))

(defmacro spacemacs|disable-company (mode)
  "Disable company for the given MODE.
MODE parameter must match the parameter used in the call to
`spacemacs|add-company-hook'."
  (let ((mode-hook (intern (format "%S-hook" mode)))
        (func (intern (format "spacemacs//init-company-%S" mode))))
    `(progn
       (remove-hook ',mode-hook ',func)
       (remove-hook ',mode-hook 'company-mode))))

(defun spacemacs//show-snippets-in-company (backend)
  (if (or (not auto-completion-enable-snippets-in-popup)
          (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))

;; Auto-complete -------------------------------------------------------------

(defmacro spacemacs|enable-auto-complete (mode)
  "Enable auto-complete for the given MODE.
The initialization function is hooked to `MODE-hook'."
  (let ((mode-hook (intern (format "%S-hook" mode)))
        (func (intern (format "spacemacs//init-auto-complete-%S" mode))))
    `(when (configuration-layer/package-usedp 'auto-complete)
       (defun ,func ()
         ,(format "Initialize auto-complete for %S" mode)
         (set (make-variable-buffer-local 'auto-completion-front-end)
              'auto-complete)
         (set (make-variable-buffer-local 'company-backends)
              ,(intern (format "company-backends-%S" mode))))
       (add-hook ',mode-hook ',func)
       (add-hook ',mode-hook 'auto-complete-mode))))

(provide 'core-auto-completion)
