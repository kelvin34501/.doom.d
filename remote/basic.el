;;; -*- lexical-binding: t; -*-

;; backup project
(add-hook 'kill-emacs-hook
          (defun usercustom-backup-project ()
            (let ((usercustom-backup-projectfile
                   (concat (file-name-directory projectile-known-projects-file) "projectile.projects.usercustom")))
              (progn
                (let ((local-list projectile-known-projects))
                  (while local-list
                    (add-to-list 'usercustom-known-projects (car local-list))
                    (setq local-list (cdr local-list))))
                (projectile-serialize usercustom-known-projects usercustom-backup-projectfile)))))


(after! projectile
  (let ((usercustom-backup-projectfile
         (concat (file-name-directory projectile-known-projects-file) "projectile.projects.usercustom")))
    (progn
      (setq usercustom-known-projects (projectile-unserialize usercustom-backup-projectfile))
      (let ((local-list usercustom-known-projects))
        (while local-list
          (add-to-list 'projectile-known-projects (car local-list) t)
          (setq local-list (cdr local-list))))
      )))


;; tramp
(after! tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))
