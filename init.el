(add-to-list 'load-path "~/.emacs.d/")
(require 'clojure-mode)
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(setq inferior-lisp-program "lein repl")
(setq ispell-dictionary "american")
inferior-lisp-program

(require 'tabbar)
(require 'project-mode)
(require 'sr-speedbar)
(require 'highlight-symbol)
(setq js-indent-level 2)
(global-set-key [(control f3)] 'highlight-symbol-at-point)
(global-set-key [f3] 'highlight-symbol-next)
(global-set-key [(shift f3)] 'highlight-symbol-prev)
(global-set-key [C-tab] 'next-buffer)
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      clojure-test-mode
                      cider))
;;(load-theme 'ample-zen)
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("e890fd7b5137356ef5b88be1350acf94af90d9d6dd5c234978cd59a6b873ea94" default))))
;; Python Hook to set tab width to 2
(add-hook 'python-mode-hook
          (function (lambda ()
                      (setq indent-tabs-mode nil
                            tab-width 2))))
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)     
;;(global-auto-complete-mode 1)

