; -*- mode: emacs-lisp; -*-

(require 'custom)
(require 'server)
(require 'uniquify)
(require 'package)

(when (>= emacs-major-version 24)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (when (not package-archive-contents) (package-refresh-contents)))

; use-package (used to control the other plugins)
(unless (package-installed-p 'use-package)
    (package-install 'use-package))

(set-face-attribute 'default nil :height 100)

(fset 'yes-or-no-p 'y-or-n-p)

(setq enable-remote-dir-locals t)
(setq echo-keystrokes 0.1)
(setq vc-mode t)
(setq ssl-program-name "gnutls-cli")
(setq ssl-program-arguments '("--insecure" "--port" service "--x509cafile" "/etc/ssl/certs/ca-certificates.crt" host))
(setq backup-inhibited t)
(setq auto-save-default nil)
(setq blink-matching-paren t)
(setq inhibit-startup-screen t)
(setq comment-multi-line t)
(setq kill-whole-line t)
(setq uniquify-buffer-name-style 'post-forward)
(setq uniquify-strip-common-suffix nil)
(setq mouse-drag-copy-region t)
(setq-default indent-tabs-mode nil)

(setq custom-file "~/.emacs.d/custom-file")
(when (file-exists-p custom-file) (load custom-file))

; visual
(set-scroll-bar-mode nil)
(menu-bar-mode 0)
(tool-bar-mode 0)

(show-paren-mode t)
(size-indication-mode t)
(column-number-mode t)
(global-font-lock-mode t)
(global-linum-mode t)
(global-hl-line-mode t)
(global-visual-line-mode t)
(global-subword-mode t)
(transient-mark-mode t)
(delete-selection-mode t)


; ---------------------------------
; global bindings
; ---------------------------------

(setq kill-whole-line t)
(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "C-M-k") 'kill-line)
(global-set-key (kbd "<C-return>") 'rectangle-mark-mode)


; Using bsd indent style
;
(c-add-style "pothix" '("bsd" (c-basic-offset . 2) (substatement-open . 0)))
(add-hook 'c-mode-hook (lambda () (c-set-style "pothix")))
(add-hook 'c++-mode-hook (lambda () (c-set-style "pothix")))
(add-hook 'c-mode-common-hook (lambda () (setq c-basic-offset 2) (setq c-set-style "bsd")))
(add-hook 'js-mode-hook (lambda () (setq js-indent-level 4)))
(add-hook 'sh-mode-hook (lambda () (setq sh-basic-offset 2)))
(add-hook 'python-mode-hook (lambda () (setq py-indent-offset 2) (modify-syntax-entry ?_ "_")))
(add-hook 'text-mode-hook 'flyspell-mode)


; No trailing whitespaces
;
(add-hook 'before-save-hook
          (lambda ()
            (when (not (derived-mode-p 'markdown-mode))
              (delete-trailing-whitespace))))

; Install solarized theme without use-package for now
; it is not working good with use-package
(unless (package-installed-p 'color-theme-solarized)
  (package-install 'color-theme-solarized))

(defun use-solarized-bgmode (frame mode)
    (set-frame-parameter frame 'background-mode mode)
      (when (not (display-graphic-p frame))
            (set-terminal-parameter (frame-terminal frame) 'background-mode mode))
        (enable-theme 'solarized))

(load-theme 'solarized t)
    (use-solarized-bgmode nil 'dark)
    (add-hook 'after-make-frame-functions
        (lambda (frame) (use-solarized-bgmode frame 'dark)))


(use-package bm
  :ensure t
  :bind (("<C-f2>" . bm-toggle)
         ("<f2>"   . bm-next)
         ("<S-f2>" . bm-previous)))

(use-package writegood-mode
  :ensure t)

(use-package artbollocks-mode
  :ensure t)

(use-package which-key
  :ensure t
  :config
  (which-key-mode))

(use-package wakatime-mode
  :ensure t
  :config (setq wakatime-cli-path "/usr/bin/wakatime"
           wakatime-python-bin "/usr/bin/python2.7")
  :init (global-wakatime-mode))

(use-package magit
  :ensure t
  :bind ("<f9>" . magit-status))

(use-package helm
  :ensure t
  :init (setq helm-command-prefix-key "C-c h")
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x b" . helm-buffers-list)))

(use-package projectile
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package helm-projectile
  :ensure t
  :bind (("C-c C-f" . helm-projectile-find-file)))

(use-package ace-jump-mode
  :ensure t
  :bind ("C-c SPC" . ace-jump-mode))

(use-package ace-jump-zap
  :ensure t
  :bind (("M-z" . ace-jump-zap-to-char)
         ("M-Z" . ace-jump-zap-up-to-char)))

(use-package ace-window
  :ensure t
  :bind ("C-x o" . ace-window)
  :config (setq aw-keys '(?a ?r ?s ?t ?h ?n ?i ?o))) ; colemak home row

(use-package discover-my-major
  :ensure t
  :bind (("C-h C-m" . discover-my-major)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  :config
  (add-hook 'text-mode-hook #'flycheck-mode)
  (add-hook 'org-mode-hook #'flycheck-mode)
  (define-key flycheck-mode-map (kbd "s-;") 'flycheck-previous-error))

(use-package py-yapf
  :ensure t
  :config
  (add-hook 'python-mode-hook #'py-yapf-enable-on-save))

; Rust related packages
(use-package flycheck-rust
  :ensure t
  :init (flycheck-rust-setup)
  :config
  (setq rust-format-on-save t)
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package rust-mode
  :ensure t)

(use-package cargo
  :config
  (add-hook 'rust-mode-hook #'cargo-minor-mode)
  :ensure t)

(use-package racer
  :ensure t
  :config
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode))

(use-package company
  :ensure t
  :config
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  (setq company-tooltip-align-annotations t)
  (add-hook 'racer-mode-hook #'company-mode))

; Elixir related packages
(use-package elixir-mode
  :ensure t)

; Go related packages
(use-package go-mode
  :ensure t)

; Ruby related packages
(use-package inf-ruby
  :ensure t)

(use-package markdown-mode+
  :ensure t)


; multiple-cursors
;
(unless (package-installed-p 'multiple-cursors)
    (package-install 'multiple-cursors))
(global-set-key (kbd "C-c m c") 'mc/edit-lines)


; expand-region
;
(unless (package-installed-p 'expand-region)
    (package-install 'expand-region))
(global-set-key (kbd "C-=") 'er/expand-region)


; highlight-symbol
;
(unless (package-installed-p 'highlight-symbol)
    (package-install 'highlight-symbol))
(global-set-key (kbd "C-#") 'highlight-symbol-next)


(defvar pthx/haskell-font-lock-extra-symbols
  '(("<alpha>" . #X03B1)
    ("<beta>" . #X03B2)
    ("<gamma>" . #X03B3)
    ("<delta>" . #X03B4)
    (".." . #X2026)
    ("`elem`" . #X2208)
    ("elem" . #X2208)
    ("^" . #X2191)))

; Emacs server
;
(unless (server-running-p) (server-start))

(setq inhibit-splash-screen t)
