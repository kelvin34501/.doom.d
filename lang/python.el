;;; -*- lexical-binding: t; -*-
;; python
(setq lsp-pyright-use-library-code-for-types t)
;(setq lsp-pyright-diagnostic-mode "workspace")
(setq lsp-pyright-auto-import-completions nil)

(put 'local-black-line-length 'safe-local-variable #'integerp)
(set-formatter! 'black ; overwrite prefefined black formatter
  '("black" "-q"
    ("--line-length" "%s" (if (boundp 'local-black-line-length) local-black-line-length 120))
    "-")
  )

(put 'local-pyvenv-path 'safe-local-variable #'stringp)
(defun local-pyvenv-auto-activate-h ()
  (if (boundp 'local-pyvenv-path)
      (progn
        (message "[hook]: local-pyvenv-path activate: %s" local-pyvenv-path)
        (pyvenv-activate (if (file-name-absolute-p local-pyvenv-path)
                             local-pyvenv-path
                           (concat (file-name-as-directory (projectile-project-root)) local-pyvenv-path)))
        )
    )
  )
(defun local-pyvenv-auto-deactivate-h ()
  (if (boundp 'local-pyvenv-path)
      (progn
        (message "[hook]: local-pyvenv-path deactivate")
        (pyvenv-deactivate)
        )
    )
  )

(add-hook 'projectile-after-switch-project-hook #'local-pyvenv-auto-activate-h)
(add-hook 'projectile-before-switch-project-hook #'local-pyvenv-auto-deactivate-h)
