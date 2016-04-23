;;
;; use-package
;;
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)

(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)


;;
;; internals
;;

;; garbage collector threshold
(setq gc-cons-threshold 20000000)


;;
;; behavior
;;

;; ido as autocompletion
(ido-mode 1)
(ido-everywhere 1)

;; use ido in most places
(use-package ido-ubiquitous :config (ido-ubiquitous-mode 1))

;; fuzzy matching
(use-package flx-ido :config (flx-ido-mode 1))

;; vertical mode
(use-package ido-vertical-mode
  :config
  (ido-vertical-mode 1)
  ;; move with C-n and C-p
  (setq ido-vertical-define-keys 'C-n-and-C-p-only))

;; M-x with ido
(use-package smex :config (global-set-key (kbd "M-x") 'smex))


;;
;; visuals
;;

(set-frame-font "Menlo-15" nil t)
(set-scroll-bar-mode nil)
(use-package solarized-theme
  :config
  (progn
    (load-theme 'solarized-light t)
    (setq x-underline-at-descent-line t)))

;; disable startup screen
(setq inhibit-startup-screen t)

;; start fullscreen (note fullscreen instead of fullboth - it's
;; a special feature of emacs-mac)
(set-frame-parameter nil 'fullscreen 'fullscreen)


;;
;; code style
;;

;; use spaces for indentation
(setq-default indent-tabs-mode nil)

;; 80 columns by default
(setq-default fill-column 80)
(setq-default truncate-lines t)

;; automatically clear trailing whitespaces, but only on lines I've edited
;; (don't be a "whitespace police")
(use-package ws-butler :config (ws-butler-global-mode 1))


;;
;; git
;;
(use-package magit
  :config
  (add-hook 'magit-blame-mode-hook 'evil-emacs-state)
  (evil-leader/set-key
    "gs" 'magit-status
    "gl" 'magit-log-current
    "gb" 'magit-blame))

(use-package magit-gitflow
  :config
  (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

;; start commit message in insert mode
(add-hook 'git-commit-mode-hook 'evil-insert-state)

;;
;; project management
;;

;; required by projectile
(use-package ag)

(use-package projectile
  :config
  (progn
    (projectile-global-mode)
    (evil-leader/set-key
      "SPC" 'projectile-toggle-between-implementation-and-test
      "t" 'projectile-find-file
      "f" 'projectile-ag
      "pp" 'projectile-switch-project)))


;;
;; languages
;;

;; ruby

;; treat _ as word character (Emacs don't do it by default, and Evil respects it)
(add-hook 'ruby-mode-hook (lambda () (modify-syntax-entry ?_ "w")))

(use-package chruby
  :init (add-hook 'ruby-mode-hook 'chruby-use-corresponding))

(use-package projectile-rails
  :init (add-hook 'projectile-mode-hook 'projectile-rails-on))

;; rspec
(defun my-rspec-verify-single ()
  "Run last spec in ruby files, and spec under point in RSpec files"
  (interactive)
  (if rspec-verifiable-mode
      (rspec-rerun)
    (rspec-verify-single)))

(use-package rspec-mode
  :config
  (progn
    (evil-leader/set-key
      "rt" 'my-rspec-verify-single
      "rs" 'rspec-verify
      "ra" 'rspec-verify-all)))

;; slim
(use-package slim-mode)


;;
;; Eeeeevil
;;

(use-package evil
  ;; all evil-want- variables go to init section
  :init
  (setq evil-want-C-u-scroll t)

  :config
  (evil-mode 1)
  (setq-default evil-shift-width 2)

  ;; a-la unimpaired
  (define-key evil-normal-state-map (kbd "]b") 'next-buffer)
  (define-key evil-normal-state-map (kbd "[b") 'previous-buffer)
  (define-key evil-normal-state-map (kbd "]q") 'next-error)
  (define-key evil-normal-state-map (kbd "[q") 'previous-error)

  ;; <leader>-like bindings
  (use-package evil-leader
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    ;; global keybindings
    (evil-leader/set-key
      "b" 'switch-to-buffer
      "q" 'delete-window
      "d" 'kill-this-buffer
      "s" 'save-buffer))

  ;; escape from anything
  (use-package evil-escape :config
    (evil-escape-mode)
    (global-set-key [escape] 'evil-escape))

  ;; gc for comments
  (use-package evil-commentary :config (evil-commentary-mode))

  ;; vim-surround clone
  (use-package evil-surround :config (global-evil-surround-mode 1))
)
