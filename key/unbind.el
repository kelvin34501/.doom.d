;;; -*- lexical-binding: t; -*-
;; unbind C-x
(map! :map ctl-x-map "a" nil)
(map! :map ctl-x-map "e" nil)
(map! :map ctl-x-map "f" nil)
(map! :map ctl-x-map "m" nil)
(map! :map ctl-x-map "n" nil)
(map! :map ctl-x-map "q" nil)
(map! :map ctl-x-map "v" nil)
(map! :map ctl-x-map "X" nil)
(map! :map ctl-x-map "DEL" nil)
(map! :map ctl-x-map "ESC" nil)
(map! :map ctl-x-map "RET" nil)
(map! :map ctl-x-map "6" nil)
(map! :map ctl-x-map "8" nil)
(map! :map ctl-x-map "*" nil)
(map! :map ctl-x-map "(" nil)
(map! :map ctl-x-map ")" nil)
(map! :map ctl-x-map "'" nil)
(map! :map ctl-x-map ";" nil)
(map! :map ctl-x-map "#" nil)
(map! :map ctl-x-map "$" nil)
(map! :map ctl-x-map "C-k" nil)
(map! :map ctl-x-map "C-;" nil)
(map! :map ctl-x-map "C-n" nil)
(map! :map ctl-x-map "C-p" nil)
(map! :map ctl-x-map "C-l" nil)
(map! :map ctl-x-map "C-u" nil)
(map! :map ctl-x-map "C-o" nil)
(map! :map ctl-x-map "C-a" nil)

;; unbind C-z
(map! :map global-map "C-z" nil)

;; unbind C-/ & C-?
(map! :map global-map
      "C-/" nil
      "C-?" nil
      )
(map! :map undo-tree-map
      "C-/" nil
      "C-?" nil
      )

;; unbind C-- & C-_ & M-- & M-_
(map! :map global-map
      "C--" nil
      "C-_" nil
      "M--" nil
      "M-_" nil
      )
(map! :map undo-tree-map
      "C--" nil
      "C-_" nil
      "M--" nil
      "M-_" nil
      )

;; unbind C-?
(map! :map global-map "C-?" nil)
