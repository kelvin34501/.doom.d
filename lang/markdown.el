;;; -*- lexical-binding: t; -*-
;; markdown

;; eww popup
;; TODO: change the preview function
(set-popup-rule! "*eww"
  :side 'right
  :action +popup-default-display-buffer-actions
  :size 0.5
  :quit 'current
  :modeline t
  )
