;----------------------------------------------------------------------

;; Set load path
(setq load-path (append '("~/.emacs.d/site-lisp") load-path))

;; Load UI specific settings
(load-file "~/.emacs.d/init/ui.el")

;; EmacsClient
(if window-system
    (if (fboundp 'server-mode) (server-mode t)))

;; Load custom OS X configuration
(if (eq system-type 'darwin)
    (load-file "~/.emacs.d/init/osx.el"))
(if (eq system-type 'gnu/linux)
    (load-file "~/.emacs.d/init/linux.el"))
(if (eq system-type 'windows-nt)
    (load-file "~/.emacs.d/init/windows.el"))

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

;; ;(setq load-path (append '("~/.emacs.d/site-lisp/cedet/common") load-path))
;; ;(setq load-path (append '("~/.emacs.d/site-lisp/cedet/eieio") load-path))
;; ;(setq load-path (append '("~/.emacs.d/site-lisp/cedet/semantic") load-path))
;(load-file "~/.emacs.d/site-lisp/cedet/common/cedet.el")
;; ;(load-file "~/.emacs.d/site-lisp/cedet/semantic/semantic-load.el")
;; ;(semantic-load-enable-gaudy-code-helpers)
;(semantic-load-enable-code-helpers)

;; (require 'semanticdb)
;; ;(global-semanticdb-minor-mode 1)
;; ;(require 'semanticdb-ectag)
;; (semantic-load-enable-primary-exuberent-ctags-support)

;; (global-semantic-idle-scheduler-mode 1) ;The idle scheduler with automatically reparse buffers in idle time.
;; (global-semantic-idle-completions-mode 1) ;Display a tooltip with a list of possible completions near the cursor.
;; (global-semantic-idle-summary-mode 1) ;Display a tag summary of the lexical token under the cursor.

;; (require 'semantic-ia)

;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)


;; tramp
(add-to-list 'load-path "~/.emacs.d/site-lisp/tramp/lisp/")
(require 'tramp)
(setq tramp-default-method "sshc")
; respect the PATH variable set
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; Load VC specific config
(load-file "~/.emacs.d/init/vc.el")

;; Load org-mode config
(load-file "~/.emacs.d/init/org.el")


(defun num-to-hex (beg end)
  "Convert a number to hex"
  (interactive "r")
  (let ((num (string-to-number (delete-and-extract-region beg end))))
    (kill-new (format "%X" num)))
  (yank))

(defun copy-and-comment-line()
  "Copy a line, and comment it out"
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (comment-region (line-beginning-position) (line-end-position))
  (open-line 1)
  (next-line 1)
  (yank))

(defun copy-and-comment-region(beg end)
  "Copy a region, comment it out"
  (interactive "r")
  (kill-ring-save beg end)
  (comment-region beg end)
  (open-line 1)
  (next-line 1)
  (yank))

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  (interactive "r")
  (let ((fill-column (point-max)))
    (fill-region start end nil)))

(global-set-key (kbd "s-l") 'copy-and-comment-line)
(global-set-key (kbd "s-;") 'copy-and-comment-region)

;(global-set-key (kbd "s-tab") 'complete-symbol)

;; Sets emacs customizations to go into a separate file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

(put 'narrow-to-region 'disabled nil)
