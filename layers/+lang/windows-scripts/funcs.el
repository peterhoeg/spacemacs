;;; funcs.el --- windows-scripts layer functions File for Spacemacs
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3



(unless dos-prefer-bat-mode
  (defun windows-scripts/dos-outline-hook ()
    (defun outline-mouse-select ()
      "Select position and return to `dos-mode'."
      (interactive)
      (dos-mode))
    (beginning-of-line))

  (defun windows-scripts/dos-outline ()
    "Set a local binding to be able to return easily in dos-mode."
    (interactive)
    (dos-outline)
    (define-key evil-normal-state-local-map
      (kbd "SPC m z") 'dos-mode)))
