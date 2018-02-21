;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    elpy
    flycheck
    material-theme
    py-autopep8))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

(elpy-enable)
(setq python-shell-interpreter "jupyter"
      python-shell-interpreter-args "console --simple-prompt")


(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(require 'undo-tree)
(global-undo-tree-mode)


;; BASIC CUSTOMIZATION
;; --------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

(menu-bar-mode -1) ;; hide menu bar
(tool-bar-mode -1) ;; hide tool bar
(scroll-bar-mode -1) ;; hide scroll bar

;; Rebindings

(define-key elpy-mode-map (kbd "<f5>") 'elpy-shell-send-buffer)
(define-key elpy-mode-map (kbd "<f9>") 'elpy-shell-send-region-or-buffer)
(define-key elpy-mode-map (kbd "<f10>") 'elpy-shell-send-codecell)

(define-key elpy-mode-map "\M-]" 'comment-region)
(define-key elpy-mode-map "\M-[" 'uncomment-region)

;; Other


;; Allow ipython buffer to be cleared

(defun my-clear ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (fill-column-indicator undo-tree py-autopep8 material-theme flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
