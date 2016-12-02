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
; functions
; ---------------------------------

(defun pothix-prepend-line (&optional arg)
  (interactive "P")
  (move-beginning-of-line arg)
  (open-line 1))

(defun pothix-append-line (&optional arg)
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
(global-set-key (kbd "C-o") 'pothix-append-line)
(global-set-key (kbd "C-S-o") 'pothix-prepend-line)
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
(add-hook 'text-mode-hook 'flyspell-mode)


; Improve transpose-chars to change chars behind it
; so, after typing `teh` it may become `the` instead of `te h`
(global-set-key (kbd "C-t")
                (lambda () (interactive)
                  (backward-char)
                  (transpose-chars 1)))


; No trailing whitespaces
;
(add-hook 'before-save-hook
          (lambda ()
            (when (not (derived-mode-p 'markdown-mode))
              (delete-trailing-whitespace))))



(use-package bm
  :bind (("<C-f2>" . bm-toggle)
         ("<f2>"   . bm-next)
         ("<S-f2>" . bm-previous)))


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



; APEL (A Portable Emacs Library) is a library to support to write portable Emacs Lisp programs.
;
(unless (package-installed-p 'apel)
    (package-install 'apel))


; which-key
(unless (package-installed-p 'which-key)
    (package-install 'which-key))
(which-key-mode)


; Magit
;
(unless (package-installed-p 'magit)
    (package-install 'magit))

(global-set-key (kbd "<f9>") 'magit-status)


; scratch
;
(unless (package-installed-p 'scratch)
    (package-install 'scratch))


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
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; enable a more powerful jump back function from ace jump mode
(autoload 'ace-jump-mode-pop-mark "ace-jump-mode" "Ace jump back:-)" t)
(eval-after-load "ace-jump-mode" '(ace-jump-mode-enable-mark-sync))


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

(with-eval-after-load 'flycheck
    (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))) ; emacs-lisp)))


; flycheck rust
;
(unless (package-installed-p 'flycheck-rust)
    (package-install 'flycheck-rust))


; rust-mode
;
(unless (package-installed-p 'rust-mode)
    (package-install 'rust-mode))


; elixir-mode
;
(unless (package-installed-p 'elixir-mode)
    (package-install 'elixir-mode))


; yaml-mode
;
(unless (package-installed-p 'yaml-mode)
    (package-install 'yaml-mode))


; multiple-cursors
;
(unless (package-installed-p 'multiple-cursors)
    (package-install 'multiple-cursors))
(global-set-key (kbd "C-c m c") 'mc/edit-lines)


; markdown-mode+
;
(unless (package-installed-p 'markdown-mode+)
    (package-install 'markdown-mode+))


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


; inf-ruby
;
(unless (package-installed-p 'inf-ruby)
    (package-install 'inf-ruby))


; haskell-mode
;
(unless (package-installed-p 'haskell-mode)
    (package-install 'haskell-mode))

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
(require 'bookmark)
(bookmark-bmenu-list)
(switch-to-buffer "*Bookmark List*")
