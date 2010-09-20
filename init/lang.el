;; *** SHELL *****************************************************************

;; Set shell mode indentation
(setq standard-indent 2)
(setq sh-indentation 2
      sh-basic-offset 2)

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
  (cperl-set-style "GNU")
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

;; Use python-mode.el instead of the standard python.el which comes with emacs
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;; ipython support (interactive python shell)
(require 'ipython)
(setq py-python-command-args '("-colors" "Linux"))

;; To fix python completion with ipython...
(setq ipython-completion-command-string "print(';'.join(__IP.Completer.all_completions('%s')))\n")

;; END PYTHON ****************************************************************


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
(add-hook 'nxml-mode-hook 'turn-on-auto-fill)
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

;; END JAVASCRIPT ************************************************************
