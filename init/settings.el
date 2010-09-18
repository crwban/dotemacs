;; Truncate lines if they are too long
(setq-default truncate-lines t)

;; Must have a newline at the end of the file
(setq require-final-newline t)

;; Keeps the cursor in the same relative row during pgups and pgdns.
(setq scroll-preserve-screen-position t)

;; Slow down scrolling speed
(setq mouse-wheel-progressive-speed nil)

;; Load windmove - shift+arrows to move between windows
(when (fboundp 'windmove-default-keybindings)
      (windmove-default-keybindings))

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Set line width to 78 columns
(setq fill-column 78)

;; setup backup dir - ~/.emacs.d/backups
(setq
 backup-by-copying t                    ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.emacs.d/backups"))        ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)                     ; use versioned backups

;; show parenthesis - what is option 1?
(show-paren-mode 1)

;; Syntax highlighting
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

(setq font-lock-support-mode 'jit-lock-mode)
(setq jit-lock-stealth-time 8
      jit-lock-defer-contextually t
      jit-lock-stealth-nice 0.5)
(setq-default font-lock-multiline t)

;; Change the way emacs makes buffer names unique...
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; icomplete mode
(icomplete-mode t)

;; Use ido for file/buffer selection
(require 'ido)
(ido-mode t)

(setq ido-ignore-buffers '("\\` " "^\*"))
(setq ido-work-directory-list-ignore-regexps '(".*"))

;; (setq 
;;  ido-ignore-buffers ;; ignore these guys
;;  '("\\` " "^\*Mess" "^\*Back" "^\*scratch" ".*Completion" "^\*Ido") 
;;  ido-everywhere t            ; use for many file dialogs
;;  ido-case-fold  t            ; be case-insensitive
;;  ido-use-filename-at-point t ; try to use filename...
;;  ido-use-url-at-point t      ; ... or url at point
;;  ido-enable-flex-matching t  ; be flexible
;;  ido-max-prospects 5         ; don't spam my minibuffer
;;  ido-confirm-unique-completion nil ; wait for RET, even with unique completion
;;  ido-auto-merge-werk-directories-length -1) ; if nothing matches, i prob. ...
;;                                         ; ... want a new file, not a weird match
