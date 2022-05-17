;;; -*- lexical-binding: t; -*-
;; c-c++
(put 'local-compile-commands-dir 'safe-local-variable #'stringp)

(defun local-lsp-activate-clangd-args ()
  (progn
    (message "[hook]: local-lsp-activate-clangd-args")
    (setq lsp-clients-clangd-args
          (let ((args '("-j=3"
                        "--background-index"
                        "--clang-tidy"
                        "--completion-style=detailed"
                        "--header-insertion=never"
                        "--header-insertion-decorators=0"))
                )
            (if (boundp 'local-compile-commands-dir)
                (add-to-list 'args
                             (format "--compile-commands-dir=%s"
                                     (if (file-name-absolute-p local-compile-commands-dir)
                                         local-compile-commands-dir
                                       (concat (file-name-as-directory (projectile-project-root)) local-compile-commands-dir))
                                     )
                             )
              args)
            )
          )
    )
  )
(defun local-lsp-deactivate-clangd-args()
  (progn
    (message "[hook]: local-lsp-deactivate-clangd-args")
    (setq lsp-clients-clangd-args '("-j=3"
                                    "--background-index"
                                    "--clang-tidy"
                                    "--completion-style=detailed"
                                    "--header-insertion=never"
                                    "--header-insertion-decorators=0"))
    )
  )

(add-hook 'projectile-after-switch-project-hook #'local-lsp-activate-clangd-args)
(add-hook 'projectile-before-switch-project-hook #'local-lsp-deactivate-clangd-args)

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--header-insertion=never"
                                "--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))
