(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need or want to do this.
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(custom-enabled-themes '(wheatgrass))
 '(indicate-buffer-boundaries 'left)
 '(menu-bar-mode nil)
 '(package-selected-packages '(telega))
 '(tool-bar-mode nil)
 '(tool-bar-position 'right))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;; мне похуй, размер менять через height
 '(default ((t (:family "SourceCodeVF" :foundry "ADBO" :slant normal :weight medium :height 140 :width normal)))))

;(add-to-list 'package-pinned-packages '(telega . "melpa-stable"))
(setq telega-server-libs-prefix "~/dev/repo/td/tdlib")
(define-key global-map (kbd "C-c t") telega-prefix-map)

;; X clipboard
;; https://unix.stackexchange.com/questions/6640/emacs-command-to-cut-or-copy-to-system-clipboard
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
; C+Insert for Copy
; S+Delete for Cut
; S+Insert Paste

; https://emacs.stackexchange.com/questions/639/how-can-i-restart-emacs-and-preserve-my-open-buffers-and-interactive-history
; ne workaet for telega
(desktop-save-mode 1)
(savehist-mode 1)
(add-to-list 'savehist-additional-variables 'kill-ring) ;; for example

(set-face-attribute 'default nil :font "Monospace" :height 120)

