;;; package ---- Summary
;;; Commentary:

;;; Code:

;; use-package setup based on https://scalameta.org/metals/docs/editors/emacs.html

(require 'package)

;; Add melpa to your packages repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

;; Install use-package if not already installed
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(require 'use-package-ensure)
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-scroll-output 'first-error)
 '(counsel-mode t)
 '(exec-path-from-shell-variables '("PATH" "MANPATH" "NIX_PATH" "NIX_SSL_CERT_FILE"))
 '(inhibit-startup-screen t)
 '(magit-repository-directories '(("~" . 2)))
 '(ns-alternate-modifier 'none)
 '(ns-command-modifier 'meta)
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(cobalt dante go-eldoc go-mode rustic rust-auto-use flycheck-julia julia-mode julia-repl julia-shell jupyter forge avy flx wgrep amx smart-mode-line-powerline-theme smart-mode-line corral ranger dired-ranger peep-dired idris-mode typescript-mode paredit flycheck-joker feature-mode yaml-mode clang-format json-mode nix-mode cider magit-todos smartparens rotate editorconfig solarized-theme haskell-mode lsp-rust rust-playground yasnippet company-racer ivy-hydra exec-path-from-shell cargo flycheck-rust racer rust-mode git-wip-timemachine git-timemachine browse-at-remote use-package better-defaults which-key magit counsel swiper ivy))
 '(rust-format-on-save t)
 '(rust-rustfmt-bin "rustfmt")
 '(sml/mode-width (if (eq (powerline-current-separator) 'arrow) 'right 'full))
 '(sml/pos-id-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   'powerline-active1 'powerline-active2)))
     (:propertize " " face powerline-active2)))
 '(sml/pos-minor-modes-separator
   '(""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   'powerline-active1 'sml/global)))
     (:propertize " " face sml/global)))
 '(sml/pre-id-separator
   '(""
     (:propertize " " face sml/global)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   'sml/global 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-minor-modes-separator
   '(""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " " 'display
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   'powerline-active2 'powerline-active1)))
     (:propertize " " face powerline-active1)))
 '(sml/pre-modes-separator (propertize " " 'face 'sml/modes))
 '(tool-bar-mode nil)
 '(tramp-syntax 'default nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package solarized-theme
  :init (load-theme 'solarized-light t))

(use-package flycheck
             :init (global-flycheck-mode))

;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; pick the exec path and other envs (customize) from shell
(use-package exec-path-from-shell
  :init (when (string= window-system "ns")
  (exec-path-from-shell-initialize)))


;; which-key-mode
(use-package which-key
  :init (which-key-mode 1))

(use-package better-defaults
  :init
  ;; save-place (as used by better-defaults is now replaced by
  ;; save-place-mode
  (if (fboundp #'save-place-mode)
      (save-place-mode +1)
    (setq-default save-place t)))

;; magit
(use-package magit
  :init
  (global-set-key (kbd "C-x g") 'magit-status)
  ;; Work around for https://github.com/magit/ghub/issues/81
  (when (< emacs-major-version 27)
    (defvar gnutls-algorithm-priority)
    (defvar ghub-use-workaround-for-emacs-bug)
    (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
          ghub-use-workaround-for-emacs-bug nil))
  (with-eval-after-load 'magit
    (use-package forge))
  )
(use-package magit-todos
  :init
  (magit-todos-mode 1)
  )

(use-package wgrep)                        ; writable grep buffer

(use-package flx)                          ; fuzzy matching

;; jump to places
(use-package avy
  :init
  (avy-setup-default)
  (global-set-key (kbd "C-c C-j") 'avy-resume)
  (global-set-key (kbd "C-:") 'avy-goto-char)
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "M-g f") 'avy-goto-line)
  (global-set-key (kbd "M-g w") 'avy-goto-word-1)
  (global-set-key (kbd "M-g e") 'avy-goto-word-0)
  )

;; ivy-counsel-swiper
(use-package ivy
  :init
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)        ; switch to buffers of files visited in a previous session
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  )
(use-package swiper)
(use-package counsel
  :init
  (global-set-key (kbd "C-s") 'counsel-grep-or-swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-rg)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)
  )
(use-package amx)                     ; last/frequent minibuffer commands

;; find files in project
(use-package find-file-in-project
  :config
  (setq ffip-use-rust-fd t)
  )

;; windmove
(setq-default windmove-wrap-around t)
(global-set-key (kbd "S-<left>")  'windmove-left)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<up>")    'windmove-up)
(global-set-key (kbd "S-<down>")  'windmove-down)

;; undo for windows
(winner-mode 1)

;; irony-mode (c++, libclang)
;; (use-package irony-mode)
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
;; Windows performance tweaks
;;
(when (boundp 'w32-pipe-read-delay)
  (setq w32-pipe-read-delay 0))
;; Set the buffer size to 64K on Windows (from the original 4K)
(when (boundp 'w32-pipe-buffer-size)
  (setq irony-server-w32-pipe-buffer-size (* 64 1024)))

;; dante-mode for haskell
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  ;; OR for flymake support:
  ;; (add-hook 'haskell-mode-hook 'flymake-mode)
  ;; (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)
  (add-hook 'haskell-mode-hook 'dante-mode)
  :config
  (flycheck-add-next-checker 'haskell-dante '(warning . haskell-hlint))
  )
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

;; fix the flycheck error at point (works with haskell-dante and emacs-lisp
(use-package attrap
  ;; :bind (("C-x /" . attrap-attrap))
  )

;; rust
(use-package rust-mode
  :init
  (setq company-tooltip-align-annotations t)
  (add-hook 'rust-mode-hook #'racer-mode)
  (add-hook 'rust-mode-hook #'linum-mode)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode)
  :config
  (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  )
(use-package flycheck-rust
  :init
  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
  )

;; enable advanced functions
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; protobuf
(use-package protobuf-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
  )
(use-package clang-format
  :init
  (add-hook 'protobuf-mode-hook
            (lambda () (add-hook 'before-save-hook clang-format-buffer nil 'local)))
  )

;; nix
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(add-to-list 'auto-mode-alist '("\\.nix.in\\'" . nix-mode))
(require 'nix-drv-mode)
(add-to-list 'auto-mode-alist '("\\.drv\\'" . nix-drv-mode))
;; provides nix-shell-(de)activate, replaces nix-mode's nix0shell.el
(require 'nix-shell)

;; cucumber/gherkin feature files
(use-package feature-mode
  :init
  (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))
)

;; clojure
(use-package flycheck-joker
  :init
  (add-hook 'clojure-mode-hook 'flycheck-mode)
  )

;; quoting and bracketing
(use-package corral
  :init
  (global-set-key (kbd "M-9") 'corral-parentheses-backward)
  (global-set-key (kbd "M-0") 'corral-parentheses-forward)
  (global-set-key (kbd "M-[") 'corral-brackets-backward)
  (global-set-key (kbd "M-]") 'corral-brackets-forward)
  ;; (global-set-key (kbd "M-{") 'corral-braces-backward)
  ;; (global-set-key (kbd "M-}") 'corral-braces-forward)
  (global-set-key (kbd "M-\"") 'corral-double-quotes-backward)
  )

;; golang
(use-package go-mode)
(use-package go-eldoc
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup)
  )
(add-hook 'go-mode-hook (lambda ()
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (local-set-key (kbd "M-.") 'godef-jump)
                          (local-set-key (kbd "M-,") 'pop-tag-mark)
                          (which-function-mode 1)
                          ))

;; Agda
(when (executable-find "agda-mode")
  (load-file (let ((coding-system-for-read 'utf-8))
               (shell-command-to-string "agda-mode locate")))
  (setq auto-mode-alist
        (append
         '(("\\.agda\\'" . agda2-mode)
           ("\\.lagda.md\\'" . agda2-mode))
         auto-mode-alist)))

;; Scala
;; Enable scala-mode for highlighting, indentation and motion commands
(use-package scala-mode
             :interpreter
             ("scala" . scala-mode))
;; Enable sbt mode for executing sbt commands
(use-package sbt-mode
             :commands sbt-start sbt-command
             :config
             ;; WORKAROUND: https://github.com/ensime/emacs-sbt-mode/issues/31
             ;; allows using SPACE when in the minibuffer
             (substitute-key-definition
              'minibuffer-complete-word
              'self-insert-command
              minibuffer-local-completion-map)
             ;; sbt-supershell kills sbt-mode:  https://github.com/hvesalai/emacs-sbt-mode/issues/152
             (setq sbt:program-options '("-Dsbt.supershell=false"))
             )

(use-package lsp-mode
             :hook  (scala-mode . lsp)
             (lsp-mode . lsp-lens-mode)
             :config
             ;; Uncomment following section if you would like to tune lsp-mode performance according to
             ;; https://emacs-lsp.github.io/lsp-mode/page/performance/
             ;;       (setq gc-cons-threshold 100000000) ;; 100mb
             ;;       (setq read-process-output-max (* 1024 1024)) ;; 1mb
             ;;       (setq lsp-idle-delay 0.500)
             ;;       (setq lsp-log-io nil)
             ;;       (setq lsp-completion-provider :capf)
             (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; Enable nice rendering of documentation on hover
;;   Warning: on some systems this package can reduce your emacs responsiveness significally.
;;   (See: https://emacs-lsp.github.io/lsp-mode/page/performance/)
;;   In that case you have to not only disable this but also remove from the packages since
;;   lsp-mode can activate it automatically.
(use-package lsp-ui)

;; lsp-mode supports snippets, but in order for them to work you need to use yasnippet
;; If you don't want to use snippets set lsp-enable-snippet to nil in your lsp-mode settings
;;   to avoid odd behavior with snippets and indentation
(use-package yasnippet)

;; Use the Debug Adapter Protocol for running tests and debugging
(use-package posframe
             ;; Posframe is a pop-up tool that must be manually installed for dap-mode
             )
(use-package dap-mode
             :hook
             (lsp-mode . dap-mode)
             (lsp-mode . dap-ui-mode)
             )

;; Purescript
(use-package psc-ide
  :config
  (setq psc-ide-use-npm-bin t)
  )

(use-package purescript-mode
  :hook
  (purescript-mode . psc-ide-mode)
  (purescript-mode . flycheck-mode)
  (purescript-mode . turn-on-purescript-indentation)
  )

(use-package nim-mode
  :mode (("\\.nim.?\\'" . nim-mode)))

;; Use company-capf as a completion provider.
;;
;; To Company-lsp users:
;;   Company-lsp is no longer maintained and has been removed from MELPA.
;;   Please migrate to company-capf.
(use-package company
             :hook (scala-mode . company-mode)
                   (purescript-mode . company-mode)
             :config
             (setq lsp-completion-provider :capf)
             :bind
             ("C-M-i" . company-complete))

;; OCaml
(use-package tuareg)
(use-package ocamlformat
  :custom (ocamlformat-enable 'enable-outside-detected-project)
  :hook (before-save . ocamlformat-before-save))

(provide 'init)
;;; init.el ends here
