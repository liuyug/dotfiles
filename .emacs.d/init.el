
; ~/.emacs.d/
(add-to-list 'load-path (expand-file-name user-emacs-directory))

(defconst *spell-check-support-enabled* nil) ;; Enable with t if you prefer

; Package initialize
; Download package.el when emacs version is less than 24
(when (< emacs-major-version 24)
  (let ((package-el (expand-file-name (format "%s/package.el" user-emacs-directory))))
    (unless (file-exists-p package-el)
      (message "Downloading to %s" package-el)
      (url-copy-file 
        "http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el"
        package-el t nil))))

(require 'package)

; Standard package repositories
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))

(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

;;; Also use Melpa for most packages
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
  If NO-REFRESH is non-nil, the available package lists will not be
  re-downloaded in order to locate PACKAGE."
  (unless (package-installed-p package min-version)
    (if (or (assoc package package-archive-contents) no-refresh)
      (package-install package)
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(package-initialize)

; color theme
(require-package 'color-theme-molokai)
;(require-package 'color-theme-solarized)
;(require-package 'color-theme-sanityinc-solarized)
;(require-package 'color-theme-sanityinc-tomorrow)
(color-theme-molokai)
;(color-theme-solarized-dark)
;(color-theme-sanityinc-solarized-light)
;(color-theme-sanityinc-tomorrow-eighties)

; line number
(setq linum-format "%3d |")
(global-linum-mode t)

(tool-bar-mode -1)
(menu-bar-mode -1)

; ; put | at 80 column
; (require-package 'fill-column-indicator)
; (require 'fill-column-indicator)
; (define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
; (global-fci-mode t)
; (setq fci-rule-character ?\u2503)

; highlight over 80 column
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)

; use spaces instead of tabs when indenting
;(add-hook 'makefile-mode)
;(setq-default indent-tabs-mode nil)
;(setq-default tab-width 4)
(setq-default c-basic-offset 4)
;(setq-default tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
;(setq-default indent-line-function 'insert-tab)

; window split
(global-set-key (kbd "C-x |") 'split-window-horizontally)
(global-set-key (kbd "C-x _") 'split-window-vertically)
; resize window size
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)
; zoom in/out in linux
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-mouse-5] 'text-scale-decrease)
; zoom in/out in window
(global-set-key [C-mouse-wheel-up-event] 'text-scale-increase)
(global-set-key [C-mouse-wheel-down-event] 'text-scale-decrease)

; vi mode in emacs
;(require-package 'evil)
;(require 'evil)
;(evil-mode 1)

; dirted
(require-package 'dired+)
(require 'dired+)
; dirtree
; (require-package 'dirtree)
; (require 'dirtree)
; (global-set-key (kbd "C-x C-d") 'dirtree)

; Interactively Do Things
(require 'ido)
(ido-mode t)
(ido-everywhere t)

(require-package 'python-mode)
(require-package 'yasnippet)
(require-package 'jedi)
(require-package 'magit)
(require-package 'autopair)

(require 'auto-complete)
(require 'yasnippet)
(require 'autopair)
(require 'python-mode)

(add-hook 'python-mode-hook 'autopair-mode)
(add-hook 'python-mode-hook 'yas-minor-mode)
(add-hook 'python-mode-hook 'auto-complete-mode)

