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
   '(attrap cobalt dante go-direx go-eldoc go-mode rustic rust-auto-use flycheck-julia julia-mode julia-repl julia-shell jupyter forge avy flx wgrep amx smart-mode-line-powerline-theme smart-mode-line corral ranger dired-ranger peep-dired idris-mode typescript-mode paredit flycheck-joker feature-mode yaml-mode clang-format json-mode nix-mode cider magit-todos smartparens rotate editorconfig solarized-theme haskell-mode lsp-rust rust-playground yasnippet company-racer ivy-hydra exec-path-from-shell cargo flycheck-rust racer rust-mode git-wip-timemachine git-timemachine browse-at-remote use-package better-defaults which-key magit counsel swiper ivy))
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
