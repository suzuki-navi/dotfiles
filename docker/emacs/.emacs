;; ファイル保存時に ~付きのファイルを作成しない
(setq backup-inhibited t)

(global-set-key "\C-h" 'delete-backward-char)

(menu-bar-mode 0)
(line-number-mode t) ;; カーソルの位置が何行目かを表示する
(column-number-mode t) ;; カーソルの位置が何文字目かを表示する

(setq scroll-conservatively 1) ;; 画面の上端か下端でカーソル移動したときに１行のみスクロール

(global-whitespace-mode 1)
(setq whitespace-space-regexp "\\(\u3000\\)")
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-display-mappings ())
;      '((space-mark ?\u0020 [?\u0020])
;        (tab-mark ?\t [?\xBB ?\t] [?\\ ?\t])))
;        (tab-mark ?\t [?\t])))

;; 改行・タブ・スペースを色付け
;;	:tab
;; :space
;; tail space: 
;;　:wide-width space
(set-face-foreground 'whitespace-tab "yellow")
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "yellow")
(set-face-background 'whitespace-space "red")
(set-face-underline  'whitespace-space t)
(setq-default show-trailing-whitespace t) ;; 行末の空白を表示

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)
;(setq indent-line-function 'indent-relative-maybe)
(setq indent-line-function 'indent-relative)

(defadvice fundamental-mode (after insert-tab-char-as-is activate)
  (local-set-key (kbd "TAB") (lambda () (interactive) (insert ?\t))))

;(add-hook 'java-mode-hook
;          '(lambda ()
;                   (c-toggle-electric-state -1)
;                   (setq indent-line-function 'indent-relative)))

;; Yes/Noの入力をY/Nに変更
(fset 'yes-or-no-p 'y-or-n-p)

(show-paren-mode 1) ;; 対応する括弧を光らせる
(setq show-paren-style 'mixed) ;; ウィンドウ内に収まらないときは括弧の中も光らせる

;; 左端に行番号を表示
(require 'linum)
(global-linum-mode)
(global-set-key "\C-x;" 'linum-mode)

(global-set-key "\C-x:" 'goto-line)

(global-set-key "\C-t" 'call-last-kbd-macro)

(global-set-key "\C-m" 'newline)
(global-set-key "\C-j" 'newline-and-indent)

(setq ruby-insert-encoding-magic-comment nil)

(add-to-list 'load-path "~/.emacs.d/anything")

;; anything
(require 'anything-config)
(global-set-key "\C-x\C-b" 'anything)
(setq anything-sources
  (list
        anything-c-source-recentf
        anything-c-source-file-name-history
        anything-c-source-files-in-current-dir
        anything-c-source-buffers
        anything-c-source-complex-command-history
        anything-c-source-emacs-commands
    ))

;(require 'scala-mode-auto)

