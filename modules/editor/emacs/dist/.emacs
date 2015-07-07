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


; ---------------------------------
; functions
; ---------------------------------

(defun dgvncsz0f-prepend-line (&optional arg)
  (interactive "P")
  (move-beginning-of-line arg)
  (open-line 1))

(defun dgvncsz0f-append-line (&optional arg)
  (interactive "P")
  (move-end-of-line arg)
  (open-line 1)
  (forward-line 1))


; ---------------------------------
; global bindings
; ---------------------------------

(setq kill-whole-line t)
(global-set-key (kbd "C-k") 'kill-whole-line)
(global-set-key (kbd "C-M-k") 'kill-line)
(global-set-key (kbd "C-o") 'dgvncsz0f-append-line)
(global-set-key (kbd "C-S-o") 'dgvncsz0f-prepend-line)
(global-set-key (kbd "<C-return>") 'rectangle-mark-mode)


; Using bsd indent style
;
(c-add-style "pothix" '("bsd" (c-basic-offset . 2) (substatement-open . 0)))
(add-hook 'c-mode-hook (lambda () (c-set-style "pothix")))
(add-hook 'c++-mode-hook (lambda () (c-set-style "pothix")))
(add-hook 'c-mode-common-hook (lambda () (setq c-basic-offset 2) (setq c-set-style "bsd")))
(add-hook 'js-mode-hook (lambda () (setq js-indent-level 2)))
(add-hook 'sh-mode-hook (lambda () (setq sh-basic-offset 2)))
(add-hook 'python-mode-hook (lambda () (setq py-indent-offset 2) (modify-syntax-entry ?_ "_")))


; No trailing whitespaces
;
(add-hook 'before-save-hook
          (lambda ()
            (when (not (derived-mode-p 'markdown-mode))
              (delete-trailing-whitespace))))


; Solarized
;
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



; Magit
;
(unless (package-installed-p 'magit)
    (package-install 'magit))

(setq magit-last-seen-setup-instructions "1.4.0")
(global-set-key (kbd "<f9>") 'magit-status)


; Helm
;
(unless (package-installed-p 'helm)
  (package-install 'helm))

(require 'helm-config)
(helm-mode t)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-c h") 'helm-command-prefix)

(define-key helm-find-files-map (kbd "<tab>") 'helm-execute-persistent-action)


; full-ack
;
(unless (package-installed-p 'full-ack)
    (package-install 'full-ack))
(require 'full-ack)
(global-set-key (kbd "M-n") 'next-error)
(global-set-key (kbd "M-p") 'previous-error)


; dired+
;
(unless (package-installed-p 'dired+)
    (package-install 'dired+))
(require 'dired+)
(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map (kbd "M-g") 'ack)))


; Projectile
;
(unless (package-installed-p 'projectile)
    (package-install 'projectile))


; Helm - projectile
;
(unless (package-installed-p 'helm-projectile)
    (package-install 'helm-projectile))

(require 'helm-projectile)
(global-set-key (kbd "C-c C-f") 'helm-projectile-find-file)


; Ace jump
;
(unless (package-installed-p 'ace-jump-mode)
  (package-install 'ace-jump-mode))
(require 'ace-jump-mode)

(autoload 'ace-jump-mode "ace-jump-mode" "Emacs quick move minor mode" t)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)


; Ace jump Zap
;
(unless (package-installed-p 'ace-jump-zap)
    (package-install 'ace-jump-zap))
(define-key global-map (kbd "M-z") 'ace-jump-zap-to-char)
(define-key global-map (kbd "M-Z") 'ace-jump-zap-up-to-char)


; Ace window
;
(unless (package-installed-p 'ace-window)
    (package-install 'ace-window))
(global-set-key (kbd "C-x o") 'ace-window)
(setq aw-keys '(?a ?r ?s ?t ?h ?n ?i ?o)) ; colemak home row


; Dot mode
;
(unless (package-installed-p 'dot-mode)
    (package-install 'dot-mode))
(require 'dot-mode)
(add-hook 'find-file-hooks 'dot-mode-on)
(autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
(global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)(message "Dot mode activated.")))


; Discover my major
;
(unless (package-installed-p 'discover-my-major)
    (package-install 'discover-my-major))
(global-set-key (kbd "C-h C-m") 'discover-my-major)


; Bookmark+
;
(unless (package-installed-p 'bookmark+)
    (package-install 'bookmark+))
(require 'bookmark+)


; flycheck
;
(unless (package-installed-p 'flycheck)
    (package-install 'flycheck))
(add-hook 'after-init-hook #'global-flycheck-mode)



; Emacs server
;
(unless (server-running-p) (server-start))
