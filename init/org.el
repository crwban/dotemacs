;; org-mode stuff

;(setq load-path (cons "~/.emacs.d/site-lisp/org/lisp" load-path))
(setq load-path (cons "~/.emacs.d/site-list/org-mode/lisp" load-path))
(setq load-path (cons "~/.emacs.d/site-list/org-mode/contrib/lisp" load-path))

(require 'org-install)

;(setq org-CUA-compatible t)
(setq org-replace-disputed-keys t)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
;(add-hook 'org-mode-hook 'flyspell-mode)

(setq org-directory "~/org/")

(setq org-agenda-files (reverse (file-expand-wildcards "~/org/journal/*.org")))

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-startup-folded "showall")
;(setq org-hide-leading-stars t)

(setq org-completion-use-ido t)

(defvar org-journal-dir "~/org/journal" "Path to OrgMode journal files.")
(defvar org-journal-file-format "/%Y-%m.org" "Format string for journal filenames.")
(defvar org-journal-date-format "%Y-%m-%d (%a)" "Date format string for journal headings.")

(defun org-journal-show ()
  "Show org journal in another window."
  (interactive)
  (let ((journal-file (concat org-journal-dir (format-time-string org-journal-file-format))))
    (find-file-other-window journal-file)))

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (unless (file-exists-p org-journal-dir)
    (make-directory org-journal-dir t))
  (org-journal-show)
  (widen)
  (let ((today (format-time-string org-journal-date-format))
        (isearch-forward t))
    (beginning-of-buffer)
    (unless (org-goto-local-search-headings today nil t)
      (org-insert-heading)
      (insert today)
      (insert "\n\n")
      (backward-char 1))
    (org-show-entry)
    (org-narrow-to-subtree)
    (delete-trailing-whitespace)
    (end-of-buffer)
    (delete-blank-lines)
    (insert "\n\n")
    (backward-char 1)
    (widen)))

(require 'remember)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

(add-hook 'org-load-hook
          (lambda ()
            ; Change the 4th level org face - light purple-y
            (set-face-attribute 'org-level-4 nil
                                :foreground "thistle2")))

;; (setq org-remember-templates
;;       '(("todo" ?t "* TODO %?\n  %i\n  %a" "~/org/codex.org" "Tasks")
;;         ("notes" ?n "* %?\n  %i\n  %a" "~/org/codex.org" "Inbox and Notes")
;;         ("blog" ?b "* %U %?\n\n  %i\n  %a" "~/org/blog.org")
;;         ("technology" ?s "* %U %?\n\n  %i\n  %a" "~/org/technology.org")
;;         ("fiction" ?f "* %U %?\n\n  %i\n  %a" "~/org/fiction.org"))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-ido-switchb)
(global-set-key "\C-cr" 'org-remember)
(global-set-key "\C-cj" 'org-journal-entry)
