;;; package ---- Summary
;;; Commentary:

;;; Code:

(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-scroll-output (quote first-error))
 '(counsel-mode t)
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(exec-path-from-shell-variables (quote ("PATH" "MANPATH" "NIX_PATH")))
 '(inhibit-startup-screen t)
 '(magit-repository-directories (quote (("~" . 2))))
 '(ns-alternate-modifier (quote none))
 '(ns-command-modifier (quote meta))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.org/packages/"))))
 '(package-enable-at-startup nil)
 '(package-selected-packages
   (quote
    (dante go-direx go-eldoc go-mode rustic rust-auto-use flycheck-julia julia-mode julia-repl julia-shell jupyter forge avy flx wgrep amx smart-mode-line-powerline-theme smart-mode-line corral ranger dired-ranger peep-dired idris-mode typescript-mode paredit flycheck-joker feature-mode yaml-mode clang-format json-mode nix-mode cider magit-todos smartparens rotate editorconfig solarized-theme haskell-mode lsp-rust rust-playground yasnippet company-racer ivy-hydra exec-path-from-shell cargo flycheck-rust racer rust-mode git-wip-timemachine git-timemachine browse-at-remote use-package better-defaults which-key magit counsel swiper ivy)))
 '(rust-format-on-save t)
 '(rust-rustfmt-bin "rustfmt")
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(tool-bar-mode nil)
 '(tramp-syntax (quote default) nil (tramp)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'flycheck)
(global-flycheck-mode 1)

;; load-path
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; pick the exec path and other envs from shell
(require 'exec-path-from-shell)
(when (string= window-system "ns")
  (exec-path-from-shell-initialize))

;; which-key-mode
(require 'which-key)
(which-key-mode 1)

;; https://github.com/technomancy/better-defaults
(require 'better-defaults)
;; save-place (as used by better-defaults is now replaced by
;; save-place-mode
(if (fboundp #'save-place-mode)
  (save-place-mode +1)
  (setq-default save-place t))
;; disable ido-mode (better-defaults enables it, unfortunately)
(ido-mode -1)

;; magit
(require 'magit)
(global-set-key (kbd "C-x g") 'magit-status)
(global-magit-file-mode)
(require 'magit-todos)
(magit-todos-mode 1)
;; Work around for https://github.com/magit/ghub/issues/81
(when (< emacs-major-version 27)
  (defvar gnutls-algorithm-priority)
  (defvar ghub-use-workaround-for-emacs-bug)
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
        ghub-use-workaround-for-emacs-bug nil))
(with-eval-after-load 'magit
  (require 'forge))

(require 'wgrep)                        ; writable grep buffer

(require 'flx)                          ; fuzzy matching

(require 'avy)                           ; jump to places
(avy-setup-default)
(global-set-key (kbd "C-c C-j") 'avy-resume)
(global-set-key (kbd "C-:") 'avy-goto-char)
(global-set-key (kbd "C-'") 'avy-goto-char-2)
(global-set-key (kbd "M-g f") 'avy-goto-line)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g e") 'avy-goto-word-0)

;; ivy-counsel-swiper
(require 'ivy)
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)        ; switch to buffers of files visited in a previous session
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(require 'swiper)
(global-set-key (kbd "C-s") 'counsel-grep-or-swiper)
(require 'counsel)
(require 'amx)                     ; last/frequent minibuffer commands
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

;; windmove
(setq-default windmove-wrap-around t)
(global-set-key (kbd "S-<left>")  'windmove-left)
(global-set-key (kbd "S-<right>") 'windmove-right)
(global-set-key (kbd "S-<up>")    'windmove-up)
(global-set-key (kbd "S-<down>")  'windmove-down)

;; undo for windows
(winner-mode 1)

;; irony-mode (c++, libclang)
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
(require 'dante)
(add-hook 'dante-mode-hook
   '(lambda () (flycheck-add-next-checker 'haskell-dante
                '(warning . haskell-hlint))))
(add-hook 'haskell-mode-hook 'flycheck-mode)
(add-hook 'haskell-mode-hook 'dante-mode)

;; rust
(require 'rust-mode)
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
(setq company-tooltip-align-annotations t)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
(require 'flycheck-rust)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook #'linum-mode)

;; enable advanced functions
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; protobuf
(require 'protobuf-mode)
(add-to-list 'auto-mode-alist '("\\.proto\\'" . protobuf-mode))
(require 'clang-format)
(add-hook 'protobug-mode-hook
          (lambda () (add-hook 'before-save-hook clang-format-buffer nil 'local)))

;; nix
(require 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))
(add-to-list 'auto-mode-alist '("\\.nix.in\\'" . nix-mode))
(require 'nix-drv-mode)
(add-to-list 'auto-mode-alist '("\\.drv\\'" . nix-drv-mode))
;; provides nix-shell-(de)activate, replaces nix-mode's nix0shell.el
(require 'nix-shell)

;; cucumber/gherkin feature files
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; clojure
(require 'flycheck-joker)
(add-hook 'clojure-mode-hook 'flycheck-mode)

;; quoting and bracketing
(require 'corral)
(global-set-key (kbd "M-9") 'corral-parentheses-backward)
(global-set-key (kbd "M-0") 'corral-parentheses-forward)
(global-set-key (kbd "M-[") 'corral-brackets-backward)
(global-set-key (kbd "M-]") 'corral-brackets-forward)
;; (global-set-key (kbd "M-{") 'corral-braces-backward)
;; (global-set-key (kbd "M-}") 'corral-braces-forward)
(global-set-key (kbd "M-\"") 'corral-double-quotes-backward)

;; golang
(require 'go-mode)
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(require 'go-direx)
(add-hook 'go-mode-hook (lambda ()
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (local-set-key (kbd "M-.") 'godef-jump)
                          (local-set-key (kbd "M-,") 'pop-tag-mark)
                          (which-function-mode 1)
                          ))
(provide 'init)
;;; init.el ends here
