(setq package-archives '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize) ;; You might already have this line

;;===========================================通用配置================================================
;;关闭自动保存
(setq auto-save-default nil)
;;关闭自动备份
(setq make-backup-files nil)
;;关闭同时编辑同一文件产生的.#xx文件
(setq create-lockfiles nil)

;;设置编码为UTF-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;;Tab设置(空格替代, 4字符)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;;括号对齐, 补全
(show-paren-mode t)
(require 'electric)
(electric-indent-mode t)
(electric-pair-mode t)
(electric-layout-mode t)

;;显示行号
(global-linum-mode 1)
(setq linum-format "%d| ")

;;===========================================通用配置================================================

;;-------------------------------------------插件配置------------------------------------------------
;;helm配置
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-c r") 'helm-recentf)
;;(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(setq helm-M-x-fuzzy-match t)
(helm-mode 1)

;;helm-gtags
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )
(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;;(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;;(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
;;(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
;;(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)



;;undo tree
(global-undo-tree-mode)

;;company-mode
(company-mode 1)
(add-hook 'after-init-hook 'global-company-mode)

;;cedet配置
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-completions-mode t)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode t)
(global-ede-mode 1)

;;ecb配置
(require 'ecb)
(setq stack-trace-on-error nil)
(setq ecb-examples-bufferinfo-buffer-name nil)

;;auto-highlight-symbol
(global-auto-highlight-symbol-mode 1)
;;---------------------------------------------插件配置-------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-gtags-modes (quote (prog-mode jde-mode cc-mode)))
 '(company-idle-delay 0.2)
 '(company-minimum-prefix-length 1)
 '(ede-project-directories (quote ("/home/wqw/code/linuxheader/include")))
 '(package-selected-packages
   (quote
    (highlight-parentheses auto-highlight-symbol ecb company-c-headers company-ycmd company undo-tree helm-gtags helm helm-ebdb electric-spacing))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
