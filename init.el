(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
			 ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

(setq backup-directory-alist (quote (("." . "~/.backups"))))

(setq tool-bar-mode 0)
(setq inhibit-startup-message 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   (quote
    (undo-tree modern-cpp-font-lock srefactor xref company-inf-ruby undo-fu counsel-gtags projectile-ripgrep ag company-rtags robe rvm gxref counsel-projectile ivy-rtags rtags company-ctags counsel-etags company swiper-helm avy counsel use-package)))
 '(safe-local-variable-values (quote ((counsel-etags-project-root . "./trunk"))))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "FreeMono" :foundry "GNU " :slant normal :weight normal :height 98 :width normal)))))


;;wqw custome emacs config------
;;                             |
;;                             V


(require 'cedet)
(require 'ivy)
(require 'counsel)
(require 'swiper)
(require 'company)
(require 'counsel-etags)
(require 'company-ctags)

(use-package ivy
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))


(use-package company
  :init (global-company-mode 1))

(use-package robe
  :init (add-hook 'ruby-mode-hook 'robe-mode)
  :config
  (eval-after-load 'company '(push 'company-robe company-backends)))

(use-package counsel-etags
  :ensure t
  :bind (("C-]" . counsel-etags-find-tag-at-point))
  :init
  (add-hook 'prog-mode-hook
	    (lambda ()
	      (add-hook 'after-save-hook
			'counsel-etags-virtual-update-tags 'append 'local)))
  :config
  ;; Don't ask before rereading the TAGS files if they have changed
  (setq tags-revert-without-query t)
  ;; Don't warn when TAGS files are large
  (setq large-file-warning-threshold nil)
  (setq counsel-etags-update-interval 60)
  (push "build" counsel-etags-ignore-directories)
  ;; counsel-etags-ignore-directories does NOT support wildcast
  (push "build_clang" counsel-etags-ignore-directories)
  (push "build_clang" counsel-etags-ignore-directories)
  ;; counsel-etags-ignore-filenames supports wildcast
  (push "TAGS" counsel-etags-ignore-filenames)
  (push "*.json" counsel-etags-ignore-filenames))

;;for c++, can also for c;
;;because counsel-etags for c++, the generate 'TAGS' size is always 0.
(use-package counsel-gtags
  :init
  (add-hook 'c-mode-hook 'counsel-gtags-mode)
  (add-hook 'c++-mode-hook 'counsel-gtags-mode)
  :config
(with-eval-after-load 'counsel-gtags
  (define-key counsel-gtags-mode-map (kbd "M-g d") 'counsel-gtags-find-definition)
  (define-key counsel-gtags-mode-map (kbd "M-g D") 'counsel-gtags-dwim)
  (define-key counsel-gtags-mode-map (kbd "M-g r") 'counsel-gtags-find-reference)
  (define-key counsel-gtags-mode-map (kbd "M-g s") 'counsel-gtags-find-symbol)
  (define-key counsel-gtags-mode-map (kbd "M-g t") 'counsel-gtags-create-tags)
  (define-key counsel-gtags-mode-map (kbd "M-g u") 'counsel-gtags-update-tags)
  (define-key counsel-gtags-mode-map (kbd "M-g f") 'counsel-gtags-find-file)
  (define-key counsel-gtags-mode-map (kbd "M-g ]") 'counsel-gtags-go-forward)
  (define-key counsel-gtags-mode-map (kbd "M-g [") 'counsel-gtags-go-backward)))


(use-package company-ctags
  :config
  (with-eval-after-load 'company
    (company-ctags-auto-setup)))

(use-package rtags
  :init
  (add-hook 'c-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running)
  (add-hook 'objc-mode-hook 'rtags-start-process-unless-running)
  (with-eval-after-load 'company
    (push 'company-rtags company-backends))
  :config
  (setq rtags-completions-enabled t)
  (setq rtags-display-result-backend 'ivy)
  (define-key c-mode-base-map (kbd "<C-tab>") (function company-complete)))


(use-package counsel-projectile
  :init
  (projectile-mode +1)
  :config
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map))

(use-package gxref
  :config
  (add-to-list 'xref-backend-functions 'gxref-xref-backend))


(use-package cedet
  :config
  (semantic-mode 1)
  (setq semanticdb-find-default-throttle '(file local project unloaded system recursive))
)

;;(use-package undo-fu
;;  :config
;;  (global-unset-key (kbd "C-x u"))
;;  (global-set-key (kbd "C-x u")   'undo-fu-only-undo)
;;  (global-set-key (kbd "C-x r") 'undo-fu-only-redo))
;;
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))


;;python support
;;sudo apt-get install elpa-elpy 
(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable))
