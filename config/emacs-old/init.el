;; Load feature from base directory
(defun qnix-req (s)
  (require s (concat user-emacs-directory (symbol-name s))))

;; Load non-plugins
(qnix-req 'package-manager)
(qnix-req 'basics)

;; Load plugins
(let* ((paths (file-expand-wildcards (concat user-emacs-directory "qnix/*.el")))
       (p-symbols (mapcar (lambda (p-path)
                            (intern (concat "qnix/" (file-name-base p-path))))
                          paths)))
  (mapc #'qnix-req p-symbols))
