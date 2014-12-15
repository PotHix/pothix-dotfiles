; -*- mode: emacs-lisp; -*-

(require 'custom)
(require 'server)
(require 'uniquify)
(require 'package)

(when (>= emacs-major-version 24)
  (package-initialize)
  (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (when (not package-archive-contents) (package-refresh-contents)))

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
(setq custom-file "~/.emacs.d/custom-file")

(unless (package-installed-p 'color-theme-solarized)
    (package-install 'color-theme-solarized))

(condition-case nil
    (load-theme 'solarized-dark t)
  (error (message "error loading theme solarized-dark")))

(set-scroll-bar-mode nil)
(menu-bar-mode 0)
(tool-bar-mode 0)

(when (file-exists-p custom-file) (load custom-file))

(show-paren-mode t)
(size-indication-mode t)
(column-number-mode t)
(global-font-lock-mode t)
(global-linum-mode t)
(global-hl-line-mode t)
(global-visual-line-mode t)
(global-subword-mode t)
(transient-mark-mode t)
(global-set-key (kbd "<C-return>") 'rectangle-mark-mode)
(global-set-key (kbd "C-c ro") 'open-rectangle)

; Magit
;
(unless (package-installed-p 'magit)
    (package-install 'magit))

; Helm
;
(unless (package-installed-p 'helm)
  (package-install 'helm))

(global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-config)

; Projectile
;
(unless (package-installed-p 'projectile)
    (package-install 'projectile))


; Emacs server
;
(unless (server-running-p) (server-start))
