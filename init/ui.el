;; Stop initial messages - splash & scratch
(setq initial-scratch-message nil)
(setq inhibit-startup-message t)
(setq inhibit-default-init t)

;; Hide toolbar and menu - learn the keyboard shortcuts instead!
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tooltip-mode) (tooltip-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-10"))
;(add-to-list 'default-frame-alist '(font . "Inconsolata-10"))
;(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-9"))
;(add-to-list 'default-frame-alist '(font . "Dejavu Sans Mono-12"))

;; Colour themes
(setq load-path (append '("~/.emacs.d/site-lisp/color-theme") load-path))
(require 'color-theme)
;(color-theme-initialize)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (if window-system
         (color-theme-clarity))))

;; No gui dialogs
(setq use-file-dialog nil)

;; Abbreviate yes/no to y/n for prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; --------------------------------------------------------
;; nice little alternative visual bell; Miles Bader <miles /at/ gnu.org>
(defcustom echo-area-bell-string "*DING* " ;"♪"
  "Message displayed in mode-line by `echo-area-bell' function."
  :group 'user)

(defcustom echo-area-bell-delay 0.1
  "Number of seconds `echo-area-bell' displays its message."
  :group 'user)

;; internal variables
(defvar echo-area-bell-cached-string nil)
(defvar echo-area-bell-propertized-string nil)

(defun echo-area-bell ()
  "Briefly display a highlighted message in the echo-area.

The string displayed is the value of `echo-area-bell-string',
with a red background; the background highlighting extends to the
right margin.  The string is displayed for `echo-area-bell-delay'
seconds.

This function is intended to be used as a value of `ring-bell-function'."
  (unless (equal echo-area-bell-string echo-area-bell-cached-string)
    (setq echo-area-bell-propertized-string
          (propertize
           (concat
            (propertize
             "x"
             'display
             `(space :align-to (- right ,(+ 2 (length echo-area-bell-string)))))
            echo-area-bell-string)
           'face '(:background "red")))
    (setq echo-area-bell-cached-string echo-area-bell-string))
  (message echo-area-bell-propertized-string)
  (sit-for echo-area-bell-delay)
  (message ""))
(setq ring-bell-function 'echo-area-bell)

;; No beeping.
(setq visible-bell t)

;; Set initial frame size
(setq initial-frame-alist 
      '((height . 57)
        (width . 100)
        (top . 0)
        (left . 0)))
