(provide 'package-manager)

;; Install straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 5))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/raxod502/straight.el/develop/install.el"
       'silent 'inhibit-cookies)
    (goto-char (point-max))
    (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Disable package.el
;; Truly reproduceable setup
(setq package-enable-at-startup nil)

;; Use straight.el with use-package
(straight-use-package 'use-package)

;; Use straight.el without needing to add :straight t
(setq straight-use-package-by-default t)
