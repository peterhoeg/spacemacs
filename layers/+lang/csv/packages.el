;;; packages.el --- csv layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: Peter Hoeg <peter@mildred>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
(defconst csv-packages
  '(csv-mode)
  "The list of Lisp packages required by the csv layer.")

(defun csv/init-csv-mode ()
  "Initialize CSV mode"
  (use-package csv-mode
    :mode ("\\.csv\\'" . csv-mode)
    :config
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'csv-mode
        "a"  'csv-align-fields
        "u"  'csv-unalign-fields
        "tv" 'csv-toggle-invisibility
        "td" 'csv-toggle-descending)

      (evil-define-key 'normal csv-mode-map
        "gh" 'csv-backward-field
        "gl" 'csv-forward-field))))

;;; packages.el ends here
