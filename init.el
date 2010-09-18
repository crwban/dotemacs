;----------------------------------------------------------------------

;; Set load path
(setq load-path (append '("~/.emacs.d/site-lisp") load-path))

;; Load UI specific settings
(load-file "~/.emacs.d/init/ui.el")

;; EmacsClient
(if window-system
    (if (fboundp 'server-mode) (server-mode t)))

;; Load custom OS X configuration
(load-file "~/.emacs.d/init/osx.el")

;; Load custom keyboard bindings
(load-file "~/.emacs.d/init/keyb.el")

(load-file "~/.emacs.d/init/settings.el")

;; Load modeline specific settings
(load-file "~/.emacs.d/init/modeline.el")

;; Stop individual messages for flyspell
(setq flyspell-issue-message-flag nil)

;; Spelling
(ispell-change-dictionary "british" t)

;; Use text mode as the default
(setq default-major-mode 'text-mode)
;(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Set unified diff format
(setq diff-switches "-u")

;; Ediff customization
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; Load language-specific configuration
(load-file "~/.emacs.d/init/lang.el")

;; load psvn
(require 'psvn)
;(global-set-key (kbd "\C-x v l") 'svn-status-show-svn-log)
;;(global-set-key (kbd "\C-x v =") 'svn-status-show-svn-diff)
;(global-set-key (kbd "\C-x v =") 'svn-file-show-svn-diff)
;(global-set-key (kbd "\C-x v e") 'svn-file-show-svn-ediff)
;(global-set-key (kbd "\C-x v d") 'svn-status-this-directory)
;(global-set-key (kbd "\C-x v s") 'svn-status-switch-to-status-buffer)
;(global-set-key (kbd "\C-x v o") 'svn-status-pop-to-status-buffer)
;(global-set-key (kbd "\C-x v u") 'svn-status-update-buffer)
;(global-set-key (kbd "\C-x v c") 'svn-status-commit)

(setq svn-status-display-full-path t)

(require 'tramp)

;; (defun local-file-name (file-name)
;;   "Convert a full file name to a local file name that can be used for a local svn invocation."
;;   (interactive "f")
;;   (message file-name)
;;   (if (and (fboundp 'file-remote-p) (file-remote-p file-name))
;;       (message (tramp-file-name-localname (tramp-dissect-file-name file-name)))
;;     (message file-name))
;;   (if (and (fboundp 'file-remote-p) (file-remote-p file-name))
;;       (tramp-file-name-localname (tramp-dissect-file-name file-name))
;;     file-name))

(defadvice vc-svn-registered (around my-vc-svn-registered-tramp activate)
  "Don't try to use SVN on files accessed via TRAMP."
  (if (and (fboundp 'tramp-tramp-file-p)
	   (tramp-tramp-file-p (ad-get-arg 0)))
      nil
    ad-do-it))

;; Load org-mode config
(load-file "~/.emacs.d/init/org.el")

(defun num-to-hex (beg end)
  "Convert a number to hex"
  (interactive "r")
  (let ((num (string-to-number (delete-and-extract-region beg end))))
    (kill-new (format "%X" num)))
  (yank))

;; Sets emacs customizations to go into a separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)
