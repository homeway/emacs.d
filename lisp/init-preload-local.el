;; -----------------------------------------------------------------------------
;; setting font for mac system
;; 下面的设置可针对mac的X窗口版本设置字体，但考虑终端更好用，所以就免了这个设置吧
;;(set-fontset-font "fontset-default" 'han '("STSong" . "unicode-bmp"))

;; -----------------------------------------------------------------------------
;; 避免在文件相同目录下产生结尾为~的备份文件，但保留备份文件的机制
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying      t  ; Don't de-link hard links
      version-control        t  ; Use version numbers on backups
      delete-old-versions    t  ; Automatically delete excess backups:
      kept-new-versions      20 ; how many of the newest versions to keep
      kept-old-versions      5) ; and how many of the old

;; -----------------------------------------------------------------------------
;; 去掉菜单显示（mac下无法使用）
(menu-bar-mode -1)

;; -----------------------------------------------------------------------------
;; 颜色模板
(load-theme 'tango-dark' t)

;; -----------------------------------------------------------------------------
;; 默认打开大纲缩进
(setq org-startup-indented t)

;; -----------------------------------------------------------------------------
;; 配置erlang下的header信息
(setq user-mail-address "homeway.xue@gmail.com")

;; -----------------------------------------------------------------------------
;; 在org文件中支持语法高亮
(setq org-src-fontify-natively t)

(provide 'init-preload-local)
