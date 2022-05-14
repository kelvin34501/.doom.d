;;; -*- lexical-binding: t; -*-
;; python
(set-formatter! 'black ; overwrite prefefined black formatter
  '("black" "-q" "--line-length" "120" "-")
  )
(put 'local-pyvenv-path 'safe-local-variable #'stringp)

(defun local-pyvenv-auto-activate ()
  (if (boundp 'local-pyvenv-path)
      (progn
        (message "local-pyvenv-path: %s" local-pyvenv-path)
        (pyvenv-activate (concat (file-name-as-directory (projectile-project-root)) local-pyvenv-path))
        )
    (progn
      (message "local-pyvenv-path unset")
      (pyvenv-deactivate)
      )
    )
  )

(add-hook 'projectile-after-switch-project-hook #'local-pyvenv-auto-activate)
