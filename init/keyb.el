;; Get rid of the C-z "sleep" keybinding
(if window-system
    (global-unset-key "\C-z")) ; iconify-or-deiconify-frame (C-x C-z)

;; Make C-x C-c prompt to before quitting
(global-unset-key "\C-x\C-c")
(global-set-key "\C-x\C-c" 'confirm-exit-emacs)

(defun confirm-exit-emacs ()
  "ask for confirmation before exiting emacs"
   (interactive)
   (if (yes-or-no-p "Are you sure you want to exit? ")
       (save-buffers-kill-emacs)))

;; Change C-x C-b behavior so it uses bs; shows only interesting buffers.
(global-set-key "\C-x\C-b" 'bs-show)

;; imenu gives menu of names of functions defined in current buffer
(define-key global-map [S-down-mouse-3] 'imenu)

(defun smart-beginning-of-line ()
  "Move point to first non-whitespace character or beginning-of-line.

Move point to the first non-whitespace character on this line.
If point was already at that position, move point to beginning of line."
  (interactive)
  (let ((oldpos (point)))
    (back-to-indentation)
    (and (= oldpos (point))
         (beginning-of-line))))

(global-set-key (kbd "\C-a") 'smart-beginning-of-line)

;; Disable over-write mode
(put 'overwrite-mode 'disabled t)
(global-unset-key [insert])

;; Make fn-delete work as expected on a macbook keyboard
(global-set-key (kbd "<kp-delete>") 'delete-char)
(global-set-key (kbd "<C-kp-delete>") 'kill-word)
