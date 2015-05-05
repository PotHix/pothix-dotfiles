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

(defun use-solarized-bgmode (frame mode)
    (set-frame-parameter frame 'background-mode mode)
      (when (not (display-graphic-p frame))
            (set-terminal-parameter (frame-terminal frame) 'background-mode mode))
        (enable-theme 'solarized))

(load-theme 'solarized t)
    (use-solarized-bgmode nil 'dark)
    (add-hook 'after-make-frame-functions
        (lambda (frame) (use-solarized-bgmode frame 'dark)))

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
(setq magit-last-seen-setup-instructions "1.4.0")

; Helm
;
(unless (package-installed-p 'helm)
  (package-install 'helm))

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "M-l") 'helm-buffers-list)
(global-set-key (kbd "C-c h") 'helm-command-prefix)

(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)

(require 'helm-config)


; Weblogger
(unless (package-installed-p 'weblogger)
  (package-install 'weblogger))


; Ace jump
(unless (package-installed-p 'ace-jump-mode)
  (package-install 'ace-jump-mode))

(require 'ace-jump-mode)

(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

(unless (package-installed-p 'ace-jump-zap)
    (package-install 'ace-jump-zap))


; Projectile
;
(unless (package-installed-p 'projectile)
    (package-install 'projectile))


; Emacs server
;
(unless (server-running-p) (server-start))
