(after! lsp-pyright
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-tramp-connection (lambda ()
                                            (cons "pyright-langserver"
                                                  lsp-pyright-langserver-command-args)))
    :major-modes '(python-mode)
    :remote? t
    :server-id 'pyright-remote
    :multi-root t
    :priority 3
    :initialization-options (lambda () (ht-merge (lsp-configuration-section "pyright")
                                                 (lsp-configuration-section "python")))
    :initialized-fn (lambda (workspace)
                      (with-lsp-workspace workspace
                                          (lsp--set-configuration
                                           (ht-merge (lsp-configuration-section "pyright")
                                                     (lsp-configuration-section "python")))))
    :download-server-fn (lambda (_client callback error-callback _update?)
                          (lsp-package-ensure 'pyright callback error-callback))
    :notification-handlers (lsp-ht ("pyright/beginProgress" 'lsp-pyright--begin-progress-callback)
                                   ("pyright/reportProgress" 'lsp-pyright--report-progress-callback)
                                   ("pyright/endProgress" 'lsp-pyright--end-progress-callback)))))
