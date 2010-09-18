;; org-mode stuff

;(setq load-path (cons "~/.emacs.d/site-lisp/org/lisp" load-path))

;(require 'org-install)

;(setq org-CUA-compatible t)
(setq org-replace-disputed-keys t)

(add-hook 'org-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'flyspell-mode)

(setq org-directory "~/org/")

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-startup-folded "showall")
;(setq org-hide-leading-stars t)

;(defvar org-journal-file "~/org/journal.org" "Path to OrgMode journal file.")  
(defvar org-journal-dir "~/org/journal" "Path to OrgMode journal files.")
(defvar org-journal-file-format "/%Y-%m.org" "Format string for journal filenames.")
(defvar org-journal-date-format "%Y-%m-%d (%a)" "Date format string for journal headings.")

(defun org-journal-entry ()
  "Create a new diary entry for today or append to an existing one."
  (interactive)
  (unless (file-exists-p org-journal-dir)
    (make-directory org-journal-dir t))
  (let ((journal-file (concat org-journal-dir (format-time-string org-journal-file-format))))
    (switch-to-buffer (find-file journal-file))
    (widen)
    (let ((today (format-time-string org-journal-date-format))
          (isearch-forward t))
      (beginning-of-buffer)
      (unless (org-goto-local-search-headings today nil t)
        (org-insert-heading)
        (insert today)
        (insert "\n\n  \n"))
      (org-show-entry)
      (org-narrow-to-subtree)
      (delete-trailing-whitespace)
      (end-of-buffer)
      (delete-blank-lines)
      (insert "\n  \n")
      (backward-char 1))))

  ;; (interactive)
  ;; (switch-to-buffer (find-file org-journal-file))
  ;; (widen)
  ;; (let ((today (format-time-string "%Y.%m"))
  ;;       (isearch-forward t))
  ;;   (unless (org-goto-local-search-headings today nil t)
  ;;     ((lambda ()
  ;;        (beginning-of-buffer)
  ;;        (org-insert-heading)
  ;;        (insert today))))
  ;;   (show-children)
  ;;   (end-of-line)
  ;;   (insert "\n")
  ;;   (org-insert-heading)
  ;;   (org-do-demote)
  ;;   (org-insert-time-stamp (current-time))
  ;;   (insert "\n\n   ")))

(require 'remember)
(setq remember-annotation-functions '(org-remember-annotation))
(setq remember-handler-functions '(org-remember-handler))
(add-hook 'remember-mode-hook 'org-remember-apply-template)

;; (setq org-remember-templates
;;       '(("todo" ?t "* TODO %?\n  %i\n  %a" "~/org/codex.org" "Tasks")
;;         ("notes" ?n "* %?\n  %i\n  %a" "~/org/codex.org" "Inbox and Notes")
;;         ("blog" ?b "* %U %?\n\n  %i\n  %a" "~/org/blog.org")
;;         ("technology" ?s "* %U %?\n\n  %i\n  %a" "~/org/technology.org")
;;         ("fiction" ?f "* %U %?\n\n  %i\n  %a" "~/org/fiction.org"))

;(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-ido-switchb)
(global-set-key "\C-cr" 'org-remember)
(global-set-key "\C-cj" 'org-journal-entry)
