(column-number-mode t)

(load "which-func")
(which-func-mode t)

;; (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
;; (setq which-func-header-line-format
;;       '(which-func-mode
;; 	("" which-func-format
;; 	 )))

;; (defadvice which-func-ff-hook (after header-line activate)
;;   (when which-func-mode
;;     (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
;;     (setq header-line-format which-func-header-line-format)))

;(set-face-attribute
; 'header-line nil
; :background "darkslateblue"
; :foreground "yellow"
; :box '(:line-width -1 :style released-button))

(set-face-attribute
 'which-func nil
 :foreground "orange")

