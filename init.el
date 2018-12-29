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
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "")


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

;; (menu-bar-mode -1) ;; hide menu bar
(tool-bar-mode -1) ;; hide tool bar
(scroll-bar-mode -1) ;; hide scroll bar
(show-paren-mode 1) ;; Show matching parenthesis

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
 '(org-agenda-files
   (quote
    ("~/Projects/Public/PhD/stage3/text2soundscene/proto/isospace.org")))
 '(package-selected-packages
   (quote
    (poly-markdown poly-org polymode projectile yasnippet faust-mode faustine gnuplot gnuplot-mode helm-bibtexkey ob-ipython ob-prolog ob-browser ob-http org-ac org-ref htmlize markdown-mode markdown-mode+ fill-column-indicator undo-tree py-autopep8 material-theme flycheck elpy better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq reftex-default-bibliography '("~/Projects/Public/PhD/bibliography/references.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/Projects/Public/PhD/bibliography/notes.org"
      org-ref-default-bibliography '("~/Projects/Public/PhD/bibliography/references.bib")
      org-ref-pdf-directory "~/Projects/Public/PhD/bibliography/bibtex-pdfs/")

(setq bibtex-completion-bibliography "~/Projects/Public/PhD/bibliography/references.bib"
      bibtex-completion-library-path "~/Projects/Public/PhD/bibliography/bibtex-pdfs"
      bibtex-completion-notes-path "~/Projects/Public/PhD/bibliography/helm-bibtex-notes")

;; open pdf with system pdf viewer (works on mac)
(setq bibtex-completion-pdf-open-function
  (lambda (fpath)
    (start-process "open" "*open*" "open" fpath)))

;; alternative
;; (setq bibtex-completion-pdf-open-function 'org-open-file)

(setq org-latex-pdf-process (list "latexmk -shell-escape -bibtex -f -pdf %f"))

(require 'org-ref)

(require 'ob-ipython)


(local-set-key "\M-\C-g" 'org-plot/gnuplot)


(eval-after-load "ox-latex"

  ;; update the list of LaTeX classes and associated header (encoding, etc.)
  ;; and structure
  '(add-to-list 'org-latex-classes
                `("beamer"
                  ,(concat "\\documentclass[presentation]{beamer}\n"
                           "[DEFAULT-PACKAGES]"
                           "[PACKAGES]"
                           "[EXTRA]\n")
                  ("\\section{%s}" . "\\section*{%s}")
                  ("\\subsection{%s}" . "\\subsection*{%s}")
                  ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))))


(setq org-latex-listings t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa


(org-babel-do-load-languages
 'org-babel-load-languages
 '((latex . t)))

(setq org-agenda-exporter-settings
      '((ps-print-color-p 'black-white)))

;; (hs-minor-mode )

(require 'doi-utils)

(global-set-key (kbd "C-!") 'hs-hide-block)
(global-set-key (kbd "C-@") 'hs-show-block)

(defun my-restart-python-console ()
  "Restart python console before evaluate buffer or region to avoid various uncanny conflicts, like not reloding modules even when they are changed"
  (interactive)
  (kill-process "Python")
  (sleep-for 0.05)
  (kill-buffer "*Python*")
  (elpy-shell-send-region-or-buffer))


(require 'faust-mode)
(require 'faustine)
(setq auto-mode-alist (cons '("\\.dsp$" . faustine-mode) auto-mode-alist))
(global-auto-complete-mode t)

(require 'polymode)

;; Markdown polymode (example)

(defcustom pm-host/markdown
  (pm-host-chunkmode :name "markdown"
                     :mode 'markdown-mode)
  "Markdown host chunkmode"
  :group 'poly-hostmodes
  :type 'object)

(defcustom  pm-inner/markdown-fenced-code
  (pm-inner-auto-chunkmode :name "markdown-fenced-code"
                           :head-matcher "^[ \t]*```[{ \t]*\\w.*$"
                           :tail-matcher "^[ \t]*```[ \t]*$"
                           :mode-matcher (cons "```[ \t]*{?\\(?:lang *= *\\)?\\([^ \t\n;=,}]+\\)" 1))
  "Markdown fenced code block."
  :group 'poly-innermodes
  :type 'object)

(defcustom  pm-inner/markdown-inline-code
  (pm-inner-auto-chunkmode :name "markdown-inline-code"
                           :head-matcher (cons "[^`]\\(`{?[[:alpha:]+-]+\\)[ \t]" 1)
                           :tail-matcher (cons "[^`]\\(`\\)[^`]" 1)
                           :mode-matcher (cons "`[ \t]*{?\\(?:lang *= *\\)?\\([[:alpha:]+-]+\\)" 1)
                           :head-mode 'host
                           :tail-mode 'host)
  "Markdown inline code."
  :group 'poly-innermodes
  :type 'object)


(define-polymode poly-markdown-mode
  :hostmode 'pm-host/markdown
  :innermodes '(pm-inner/markdown-fenced-code
                pm-inner/markdown-inline-code))

;; Python polymode (example)

(defcustom pm-host/python
  (pm-host-chunkmode :name "python"
                     :mode 'python-mode)
  "Python host chunkmode"
  :group 'poly-hostmodes
  :type 'object)

(defcustom  pm-inner/python-fenced-code
  (pm-inner-auto-chunkmode :name "python-minor"
                           :head-matcher "^[ \t]*#\\+BEGIN_SRC[ \t]+\\w+\n+[ \t]*[A-Za-z0-9_]\+[ \t]*=[ \t]*r?[\'\"]+"
                           :tail-matcher "[\"\']+\\([A-Za-z0-9_()\\.]+\\)?\n*[ \t]*#\\+END_SRC[ \t]*"
                           :mode-matcher (cons "^[ \t]*#\\+BEGIN_SRC[ \t]+\\(\\w+\\)" 1))
  "Python fenced code block."
  :group 'poly-innermodes
  :type 'object)


(define-polymode poly-python-mode
  :hostmode 'pm-host/python
  :innermodes '(pm-inner/python-fenced-code))

