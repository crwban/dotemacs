;; On Linux, hide the menu bar...
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

;; tramp
(add-to-list 'load-path "~/.emacs.d/site-lisp/tramp/lisp/")
(require 'tramp)
(setq tramp-default-method "sshc")
; respect the PATH variable set
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)

;; (add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-10"))
(add-to-list 'default-frame-alist '(font . "Ubuntu Mono-11"))
;(add-to-list 'default-frame-alist '(font . "Inconsolata-10"))
;(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-9"))
;(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-12"))

(setq browse-url-generic-program "/home/alegri01/bin/chromium-browser")
