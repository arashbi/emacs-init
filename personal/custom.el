(require 'package)

(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("tromey" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
(add-to-list 'package-pinned-packages '(magit . "melpa-stable") t)
(setq prelude-theme 'dracula)
;; ibuffer format
(defvar jep:filename-subs
  '(("/home/jpace" . "~")
    (".*/Projects/com/mycompany/is/" . "~is/")
    ("/home/jpace/proj/org/incava/" . "~incava/")
    ("/$" . "")))


(setq ibuffer-formats
      '((mark modified read-only " "
              (name 30 30 :left :elide)
              " "
              (size 9 -1 :right)
              " "
              (filename -20 30 :right :elide))
        (mark modified read-only " "
              (name 30 30 :left :elide)
              " "
              (size 9 -1 :right)
              " " filename-and-process)
        (mark " "
              (name 30 30 :left :elide)
              " " filename-and-process)))
;; ibuffer fix

(ivy-mode 1)
(set-frame-font
 "-outline-Source Code Pro Medium-normal-normal-normal-mono-16-*-*-*-c-*-iso8859-1")
(load-theme 'omtose-softer)
(global-set-key (kbd "C-x g") 'magit-status)

;; org mode
(use-package deft
  :bind ("<f9>" . deft)
  :commands (deft)
  :config (setq deft-directory "~/Org/deft/"
                deft-default-extension "org"
                deft-extensions '("md" "org")))

(setq
 deft-extensions '("org")
 deft-directory "~/Org/deft/"
 deft-text-mode 'org-mode
 )

(setq org-todo-keywords
      '((sequence "TODO" "INPR" "|" "DONE")))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-agenda-files  '("~/Org/deft"))
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c c") 'org-capture)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

;; dart
(defun project-try-dart (dir)
  (let ((project (or (locate-dominating-file dir "pubspec.yaml")
                     (locate-dominating-file dir "BUILD"))))
    (if project
        (cons 'dart project)
      (cons 'transient dir))))
(add-hook 'project-find-functions #'project-try-dart)
(setq dart-format-on-save t)
(add-hook 'dart-mode-hook 'lsp)
(with-eval-after-load "projectile"
  (add-to-list 'projectile-project-root-files-bottom-up "pubspec.yaml")
  (add-to-list 'projectile-project-root-files-bottom-up "BUILD"))

(use-package lsp-mode :ensure t)
(use-package lsp-dart
  :ensure t
  :hook (dart-mode . lsp))
(use-package lsp-java :ensure t)
(add-hook 'java-mode-hook 'lsp)
(setq lsp-auto-guess-root t)


(defun delete-current-file ()
  "Delete current buffer/file and close the buffer, push content to `kill-ring'.
URL `http://ergoemacs.org/emacs/elisp_delete-current-file.html'
Version 2016-07-20"
  (interactive)
  (progn
    (kill-new (buffer-string))
    (message "Buffer content copied to kill-ring.")
    (when (buffer-file-name)
      (when (file-exists-p (buffer-file-name))
        (progn
          (delete-file (buffer-file-name))
          (message "Deleted file: 「%s」." (buffer-file-name)))))
    (let ((buffer-offer-save nil))
      (set-buffer-modified-p nil)
      (kill-buffer (current-buffer)))))

;;projectile
(setq projectile-project-search-path '("~/source/")
      projectile-enable-caching t
      projectile-completion-system 'ivy)

;; white space
(setq whitespace-style '(face tabs empty trailing))

(defun diary ()
  "opens diary deft"
  (interactive)
  (setq deft-directory "~/Documents/diary")
  (deft)
  (deft-refresh)
  )
(defun tasks ()
  "opens tasks deft"
  (interactive)
  (setq deft-directory "~/Org/deft")
  (deft)
  (deft-refresh)
  )

(global-set-key (kbd "<f9>") 'tasks)
(global-set-key (kbd "<f10>") 'diary)


(require 'lsp-origami )
(add-hook 'lsp-after-open-hook #'lsp-origami-try-enable)
(use-package yasnippet-lean :ensure t)
(require 'yasnippet )
(yas-global-mode 1 )
(setq yas-snippet-dirs
      '("/Users/abizhanzadeh/.emacs.d/snippets/"                 ;; personal snippets
        "/Users/abizhanzadeh/.emacs.d/snippets/dart-mode/"
        ))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(column-number-mode t)
 '(ede-project-directories '("/Users/abizhanzadeh/go/src/github.com/thumbtack/go"))
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   '(phpt-mode tree-sitter easy-hugo scss-mode terraform-mode scala-mode dockerfile-mode kotlin-mode csv-mode go-mode php-mode lsp-origami zop-to-char zenburn-theme yaml-mode which-key web-mode volatile-highlights use-package undo-tree tide super-save smartrep smartparens rainbow-mode rainbow-delimiters org-roam org-bullets operate-on-number nlinum move-text magit lsp-ui lsp-java lsp-dart key-chord json-mode js2-mode imenu-anywhere hl-todo helm-projectile guru-mode git-timemachine git-modes gist geiser expand-region exec-path-from-shell elisp-slime-nav editorconfig easy-kill dracula-theme discover-my-major diminish diff-hl deft crux counsel company cider browse-kill-ring anzu ag))
 '(size-indication-mode t)
 '(tool-bar-mode nil))
;; Sample jar configuration
(setq plantuml-jar-path "/Users/abizanz/tools/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
(setq puml-output-type 'txt )

(setq projectile-indexing-method 'native)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#3F3F3F" :foreground "#DCDCCC" :inverse-video nil :box nil :strike-through nil :extend nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Menlo"))))
 '(bold ((t nil))))
(global-visual-line-mode)
(setq org-agenda-files (list "~/Org/deft" "~/Dropbox/notes"))
(org-mode)

(defun commit-deft ()
  ;; commit the deft directory to github
  (async-shell-command "sh ~/org/deft/cron.sh ~/org/deft/&")
    )
(commit-deft)
(run-with-timer 0 (* 30 60) 'commit-deft )
