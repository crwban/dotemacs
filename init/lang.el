;; *** SHELL *****************************************************************

;; Set shell mode indentation
(setq standard-indent 4)
(setq sh-indentation 4
      sh-basic-offset 4)

;; END SHELL *****************************************************************


;; PERL **********************************************************************

;;; use cperl-mode instead of perl-mode                                        
(defalias 'perl-mode 'cperl-mode)
;; Turns on most of the CPerlMode options
;(setq cperl-hairy t)

;(setq cperl-electric-parens t
;      cperl-electric-keywords t
;      cperl-electric-linefeed t
;      cperl-electric-lbrace-space t)

;;  When starting load my hooks
(add-hook 'cperl-mode-hook 'my-cperl-mode-hook t)

(defun my-cperl-mode-hook ()
  (cperl-set-style "CPerl")
  (setq cperl-indent-level 4)
  (local-set-key (kbd "\C-c t") 'perltidy-buffer))
;  (local-set-key (kbd "\C-c c") 'perlcritic))

(defun perltidy-region ()
 "Run perltidy on the current region."
 (interactive)
 (save-excursion
   (shell-command-on-region (point) (mark) "perltidy -q" nil t)))

;; (defun perltidy-defun ()
;;   "Run perltidy on the current defun."
;;   (interactive)
;;   (save-excursion (mark-defun)
;;                   (perltidy-region)))

(defun perltidy-buffer ()
  "Run perltidy on the current buffer."
  (interactive)
  (save-excursion (mark-whole-buffer)
                  (perltidy-region)))

;(setq load-path (append '("~/.emacs.d/site-lisp/pde") load-path))
;(require 'perlcritic)

;; END PERL ******************************************************************


;; PYTHON ********************************************************************

(setq load-path (append '("~/.emacs.d/site-lisp/python-mode") load-path))
(setq py-install-directory "~/.emacs.d/site-lisp/python-mode")

;;  When starting load my hooks
(add-hook 'python-mode-hook 'my-python-mode-hook t)

(defun my-python-mode-hook ()
  (local-set-key [(control backspace)] 'backward-kill-word)
  (setq tab-width 4)
  (setq imenu-create-index-function #'py-imenu-create-index-new)
  (setq py-shell-name "ipython")
  (unless (eq buffer-file-name nil) (flymake-mode 1)))

;; Use python-mode.el instead of the standard python.el which comes with emacs
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ;; (list "pyflakes"  (list local-file))))
      (list "epylint"  (list local-file))))

  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

;; END PYTHON ****************************************************************

;; C/C++ *********************************************************************

(defconst fastsim-c-style
       '((indent-tabs-mode . nil)
         (c-basic-offset . 4)
         (tab-width . 8)
         (c-comment-only-line-offset . 0)
         (c-hanging-braces-alist . ((substatement-open before after)))
         (c-offsets-alist . ((statement-block-intro . +)
                             (substatement-open . 0)
                             (label . 0)
                             (statement-cont . +)
                             (innamespace . 0)
                             (inline-open . 0)
                             ))
         )
       "FastSim C++ Programming Style")

(defun my-c-hook ()
  (c-add-style "fastsim" fastsim-c-style t)
  (c-set-style "fastsim")
)

(add-hook 'c-mode-hook 'my-c-hook)
(add-hook 'c++-mode-hook 'my-c-hook)

;; END C/C++ *****************************************************************

;; XML ***********************************************************************

;; Use nXML for XML files
(add-to-list 'auto-mode-alist
             (cons (concat "\\." (regexp-opt '("xml" "xsd" "sch" "rng" "xslt" "svg" "rss") t) "\\'")
                   'nxml-mode))

(unify-8859-on-decoding-mode)

(setq magic-mode-alist
      (cons '("<＼＼?xml " . nxml-mode)
            magic-mode-alist))
(fset 'xml-mode 'nxml-mode)

(setq nxml-slash-auto-complete-flag t)
;(add-hook 'nxml-mode-hook 'turn-on-auto-fill)
(add-hook 'nxml-mode-hook 'flyspell-mode)

;; END XML *******************************************************************


;; YAML **********************************************************************

;; yaml mode...
;(require 'yaml-mode)
;(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; END YAML ******************************************************************


;; JAVASCRIPT ****************************************************************

;; js2-mode (javascript)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Load espresso-mode
(autoload 'espresso-mode "espresso" nil t)

;; END JAVASCRIPT ************************************************************


;; HTML **********************************************************************

(load "~/.emacs.d/site-lisp/nxhtml/autostart.el")

; This makes 
(defalias 'html-mode 'nxhtml-mode)

(setq nxml-child-indent standard-indent)

;; END HTML ******************************************************************


;; TEMPLATE TOOLKIT **********************************************************

; This needs nxhtml mode to be loaded already
(add-to-list 'auto-mode-alist '("\\.tt$" . tt-html-mumamo-mode))

;; END TEMPLATE TOOLKIT ******************************************************
