(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compilation-scroll-output 'first-error)
 '(counsel-mode t)
 '(exec-path-from-shell-variables '("PATH" "MANPATH" "NIX_PATH"))
 '(inhibit-startup-screen t)
 '(magit-repository-directories '(("~" . 2)))
 '(ns-alternate-modifier 'none)
 '(ns-command-modifier 'meta)
 '(package-enable-at-startup nil)
 '(package-selected-packages
   '(amx avy better-defaults browse-at-remote cargo cider clang-format cobalt company-racer corral counsel dante dired-ranger editorconfig exec-path-from-shell feature-mode flx flycheck-joker flycheck-julia flycheck-rust forge git-timemachine git-wip-timemachine go-direx go-eldoc go-mode haskell-mode idris-mode ivy ivy-hydra json-mode julia-mode julia-repl julia-shell jupyter lsp-rust lsp-ui magit magit-todos nix-mode paredit peep-dired racer ranger rotate rust-auto-use rust-mode rust-playground rustic scalariform smart-mode-line smart-mode-line-powerline-theme smartparens solarized-theme swiper typescript-mode use-package wgrep which-key yaml-mode yasnippet))
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
