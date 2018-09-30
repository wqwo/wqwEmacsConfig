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

;;跳转到指定行
(define-key global-map "\C-c\C-g" 'goto-line)
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


;;undo tree
(global-undo-tree-mode)

;;company-mode
(company-mode 1)
(add-hook 'after-init-hook 'global-company-mode)

;;ggtags
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))
(ggtags-mode 1)

;;auto-highlight-symbol
(global-auto-highlight-symbol-mode 1)

;;rtags
(require 'rtags)
(require 'company)
(setq rtags-autostart-diagnostics t)
(rtags-diagnostics)
(setq rtags-completions-enabled t)
(push 'company-rtags company-backends)
(global-company-mode)
(define-key c-mode-base-map (kbd "<C-Tab>") (function company-complete))

(defun use-rtags (&optional useFileManager)
  (and (rtags-executable-find "rc")
       (cond ((not (gtags-get-rootpath)) t)
             ((and (not (eq major-mode 'c++-mode))
                   (not (eq major-mode 'c-mode))) (rtags-has-filemanager))
             (useFileManager (rtags-has-filemanager))
             (t (rtags-is-indexed)))))

(defun tags-find-symbol-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-symbol-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-tag)))
(defun tags-find-references-at-point (&optional prefix)
  (interactive "P")
  (if (and (not (rtags-find-references-at-point prefix)) rtags-last-request-not-indexed)
      (gtags-find-rtag)))
(defun tags-find-symbol ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-symbol 'gtags-find-symbol)))
(defun tags-find-references ()
  (interactive)
  (call-interactively (if (use-rtags) 'rtags-find-references 'gtags-find-rtag)))
(defun tags-find-file ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-find-file 'gtags-find-file)))
(defun tags-imenu ()
  (interactive)
  (call-interactively (if (use-rtags t) 'rtags-imenu 'idomenu)))

(define-key c-mode-base-map (kbd "M-.") (function tags-find-symbol-at-point))
(define-key c-mode-base-map (kbd "M-,") (function tags-find-references-at-point))
(define-key c-mode-base-map (kbd "M-;") (function tags-find-file))
(define-key c-mode-base-map (kbd "C-.") (function tags-find-symbol))
(define-key c-mode-base-map (kbd "C-,") (function tags-find-references))
(define-key c-mode-base-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key c-mode-base-map (kbd "M-i") (function tags-imenu))

(define-key global-map (kbd "M-.") (function tags-find-symbol-at-point))
(define-key global-map (kbd "M-,") (function tags-find-references-at-point))
(define-key global-map (kbd "M-;") (function tags-find-file))
(define-key global-map (kbd "C-.") (function tags-find-symbol))
(define-key global-map (kbd "C-,") (function tags-find-references))
(define-key global-map (kbd "C-<") (function rtags-find-virtuals-at-point))
(define-key global-map (kbd "M-i") (function tags-imenu))

;;rainbow-identifier--增强语法高亮显示
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
(add-hook 'c-mode-hook 'rainbow-identifiers-mode)
(add-hook 'c++-mode-hook 'rainbow-identifiers-mode)

;;modern-cpp-font-lock
(modern-c++-font-lock-global-mode t)

;;---------------------------------------------插件配置-------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ede-project-directories (quote ("/home/wqw/code/linuxheader/include")))
 '(package-selected-packages
   (quote
    (modern-cpp-font-lock rainbow-identifiers color-identifiers-mode ggtags company-rtags rtags ecb company-c-headers company-ycmd company undo-tree helm-gtags helm helm-ebdb electric-spacing))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
