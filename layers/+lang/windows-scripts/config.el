;;; config.el --- Windows Scripts Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; variables

(defvar dos-prefer-bat-mode nil
  "Prefer the built-in bat-mode instead of dos-mode")

(if dos-prefer-bat-mode
    (spacemacs|define-jump-handlers bat-mode)
  (spacemacs|define-jump-handlers dos-mode))
