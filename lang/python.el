;;; -*- lexical-binding: t; -*-
;; python
(setq lsp-pyright-auto-import-completions nil)

(set-formatter! 'black ; overwrite prefefined black formatter
  '("black" "-q"
    ("--line-length" "%s" (if (boundp 'local-black-line-length) local-black-line-length 120))
    "-")
  )
(put 'local-black-line-length 'safe-local-variable #'integerp)

(put 'local-pyvenv-path 'safe-local-variable #'stringp)
(defun local-pyvenv-auto-activate ()
  (if (boundp 'local-pyvenv-path)
      (progn
        (message "[hook]: local-pyvenv-path activate: %s" local-pyvenv-path)
        (pyvenv-activate (if (file-name-absolute-p local-pyvenv-path)
                             local-pyvenv-path
                           (concat (file-name-as-directory (projectile-project-root)) local-pyvenv-path)))
        )
    )
  )
(defun local-pyvenv-auto-deactivate ()
  (if (boundp 'local-pyvenv-path)
      (progn
        (message "[hook]: local-pyvenv-path deactivate")
        (pyvenv-deactivate)
        )
    )
  )

(add-hook 'projectile-after-switch-project-hook #'local-pyvenv-auto-activate)
(add-hook 'projectile-before-switch-project-hook #'local-pyvenv-auto-deactivate)
