;;; -*- lexical-binding: t; -*-

(setq lsp-log-io t)

;; dir local lsp ignored
(put 'local/lsp-file-watch-ignored-directories 'safe-local-variable #'proper-list-p)
(put 'local/lsp-file-watch-ignored-files 'safe-local-variable #'proper-list-p)
(defun local/lsp-file-watch-ignored-directories-append-h ()
  (if (boundp 'local/lsp-file-watch-ignored-directories)
      (progn
        (message "[hook]: local/lsp-file-watch-ignored-directories-append")
        (require 'lsp-mode)
        (if (not (boundp 'local/lsp-file-watch-ignored-directories-backup))
            (setq local/lsp-file-watch-ignored-directories-backup (cl-copy-list (lsp-file-watch-ignored-directories))))
        (let ((local-list local/lsp-file-watch-ignored-directories))
          (while local-list
            (add-to-list 'lsp-file-watch-ignored-directories (car local-list))
            (setq local-list (cdr local-list)))))))
(defun local/lsp-file-watch-ignored-files-append-h ()
  (if (boundp 'local/lsp-file-watch-ignored-files)
      (progn
        (message "[hook]: local/lsp-file-watch-ignored-files-append")
        (require 'lsp-mode)
        (if (not (boundp 'local/lsp-file-watch-ignored-files-backup))
            (setq local/lsp-file-watch-ignored-files-backup (cl-copy-list (lsp-file-watch-ignored-files))))
        (let ((local-list local/lsp-file-watch-ignored-files))
          (while local-list
            (add-to-list 'lsp-file-watch-ignored-files (car local-list))
            (setq local-list (cdr local-list)))))))
(add-hook 'projectile-after-switch-project-hook #'local/lsp-file-watch-ignored-directories-append-h)
(add-hook 'projectile-after-switch-project-hook #'local/lsp-file-watch-ignored-files-append-h)
(defun local/lsp-file-watch-ignored-directories-cleanup-h ()
  (if (boundp 'local/lsp-file-watch-ignored-directories-backup)
      (progn
        (message "[hook]: local/lsp-file-watch-ignored-directories-cleanup")
        (setq lsp-file-watch-ignored-directories (cl-copy-list local/lsp-file-watch-ignored-directories-backup))
        (makunbound 'local/lsp-file-watch-ignored-directories-backup))))
(defun local/lsp-file-watch-ignored-files-cleanup-h ()
  (if (boundp 'local/lsp-file-watch-ignored-files-backup)
      (progn
        (message "[hook]: local/lsp-file-watch-ignored-files-cleanup")
        (setq lsp-file-watch-ignored-files (cl-copy-list local/lsp-file-watch-ignored-files-backup))
        (makunbound 'local/lsp-file-watch-ignored-files-backup))))
(add-hook 'projectile-before-switch-project-hook #'local/lsp-file-watch-ignored-directories-cleanup-h)
(add-hook 'projectile-before-switch-project-hook #'local/lsp-file-watch-ignored-files-cleanup-h)
