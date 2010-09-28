(add-to-list 'vc-handled-backends 'SVN)

;; load psvn
(require 'psvn)
(global-set-key (kbd "\C-x v l") 'svn-status-show-svn-log)
;;(global-set-key (kbd "\C-x v =") 'svn-status-show-svn-diff)
(global-set-key (kbd "\C-x v =") 'svn-file-show-svn-diff)
(global-set-key (kbd "\C-x v e") 'svn-file-show-svn-ediff)
(global-set-key (kbd "\C-x v d") 'svn-status-this-directory)
;(global-set-key (kbd "\C-x v s") 'svn-status-switch-to-status-buffer)
;(global-set-key (kbd "\C-x v o") 'svn-status-pop-to-status-buffer)
;(global-set-key (kbd "\C-x v u") 'svn-status-update-buffer)
(global-set-key (kbd "\C-x v c") 'svn-status-commit)

(setq svn-status-display-full-path t)
(setq svn-log-edit-show-diff-for-commit t)
