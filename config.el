;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "kelvin34501"
      user-mail-address "kelvin34501@foxmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
(setq
 default-font "DejaVu Sans Mono"
 default-font-size 16.0
 doom-font-increment 1
 doom-font (font-spec :family default-font
                      :size default-font-size)
 )

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; Custom

;; unbind to get a cleaner emacs
(load! "key/unbind")

;; startup and quit
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(setq confirm-kill-emacs nil)

;; projectile
(setq projectile-track-known-projects-automatically nil)

;; warp line
(map! :map global-map "C-z" #'visual-line-mode)

;; bind for new-buffer
(map! "C-x n"  #'+default/new-buffer)

;; comment
(map! :map global-map "M-;" nil)
(map! :map global-map "C-/" #'comment-line)
(map! :map global-map "C-x /" #'comment-dwim)

;; tab
(map! :map ctl-x-map "t SPC" #'tab-bar-mode)

;; project add root
(map! :map projectile-command-map "SPC" #'projectile-add-known-project)

;; format
(map! :map ctl-x-map "f" #'+format/buffer)

;; region
(map! :map global-map "C-=" #'er/contract-region)
(map! :map global-map "C-+" #'er/expand-region)

;; mark

;; terminal
(map! :after vterm
      :map vterm-mode-map
      "M-m C-c" #'vterm-send-C-c
      "M-m C-x" #'vterm-send-C-x)

;; markdown-mode
(set-popup-rule! "*eww"
  :side 'right
  :action +popup-default-display-buffer-actions
  :size 0.5
  :quit 'current
  :modeline t
  )

;; undo tree
(map! :map global-map "C--" #'undo-tree-undo)
(map! :map global-map "C-_" #'undo-tree-redo)
(set-popup-rule! "*undo-tree"
  :side 'right
  :action +popup-default-display-buffer-actions
  :size 0.1
  :slot -1
  :quit t
  )
(setq undo-tree-visualizer-diff nil)

;;; lang
;; c/c++
(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; python
(load! "lang/python")
