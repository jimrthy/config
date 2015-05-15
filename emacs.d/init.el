(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "cyan"))))
 '(font-lock-comment-face ((t (:foreground "medium blue"))))
 '(font-lock-constant-face ((t (:foreground "red"))))
 '(font-lock-function-name-face ((t (:foreground "medium blue"))))
 '(font-lock-keyword-face ((t (:foreground "brightred"))))
 '(font-lock-string-face ((t (:foreground "indian red"))))
 '(font-lock-type-face ((t (:foreground "brightblack"))))
 '(font-lock-variable-name-face ((t (:foreground "color-52"))))
 '(org-date ((t (:foreground "black" :underline t))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "color-28"))))
 '(org-level-4 ((t (:inherit nil :foreground "color-54")))))


;;; Take a look at http://www.cs.utah.edu/~aek/code/init.el.html
;;; There are some interesting-looking settings in there.

;;; My vital packages!
(require 'package)
;; Apparently I want this if I'm going to be running
;; package-initialize myself
(setq package-enable-at-startup nil)
;; There are interesting debates about marmalade vs. melpa.
;; These days, there don't seem to be any significant reasons
;; to not include both
(when t (add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/")))
(when t (add-to-list 'package-archives
		     '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t))
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(cider
		      clojure-mode
		      magit
		      paredit
		      paxedit))

;; Take this away for now, to try to speed up start time
(when t (dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p))))

;;; Luddite mode
(cond ((> emacs-major-version 20)
       (tool-bar-mode -1)
       (menu-bar-mode -1)
       (scroll-bar-mode -1)
       (menu-bar-showhide-fringe-menu-customize-disable)
       (blink-cursor-mode -1)
       (windmove-default-keybindings 'meta)))

;;;; Clojure

;;; Clojurescript files should be edited in clojure-mode
(add-to-list 'auto-mode-alist '("\.cljs$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\.cljx$" . clojure-mode))

(autoload 'enable-paredit-mode "paredit" 
  "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'paredit-mode)

;;; Probationary paxedit configuration
(require 'paxedit)
(add-hook 'emacs-lisp-mode-hook 'paxedit-mode)
(add-hook 'clojure-mode-hook 'paxedit-mode)
(eval-after-load "paxedit"
  '(progn (define-key paxedit-mode-map (kbd "M-<right>") 'paxedit-transpose-forward)
	  (define-key paxedit-mode-map (kbd "M-<left>") 'paxedit-transpose-backward)
	  (define-key paxedit-mode-map (kbd "M-<up>") 'paxedit-backward-up)
	  (define-key paxedit-mode-map (kbd "M-<down>") 'paxedit-backward-end)
	  (when nil (define-key paxedit-mode-map (kbd "M-b") 'paxedit-previous-symbol)
		(define-key paxedit-mode-map (kbd "M-f") 'paxedit-next-symbol))
	  (define-key paxedit-mode-map (kbd "C-%") 'paxedit-copy)
	  (define-key paxedit-mode-map (kbd "C-&") 'paxedit-kill)
	  (define-key paxedit-mode-map (kbd "C-*") 'paxedit-delete)
	  (define-key paxedit-mode-map (kbd "C-^") 'paxedit-sexp-raise)
	  (define-key paxedit-mode-map (kbd "M-u") 'paxedit-symbol-change-case)
	  (define-key paxedit-mode-map (kbd "C-@") 'paxedit-symbol-copy)
	  (define-key paxedit-mode-map (kbd "C-#") 'paxedit-symbol-kill)))
;;; eldoc
(require 'eldoc)
(eldoc-add-command
  'paredit-backward-delete
  'paredit-close-round)

;; Recommendations from the nrepl README:
;; eldoc (shows the args to whichever function you're calling):
(add-hook 'cider-interaction-mode-hook
          'cider-turn-on-eldoc-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)

;; turn off auto-complete with tab
; (it recommends using M-tab instead)
(setq cider-tab-command 'indent-for-tab-command)
(setq cider-repl-tab-command 'indent-for-tab-command)

;; Make C-c C-z switch to *cider repl* in current window:
(when nil (setq cider-repl-display-in-current-window t))
;; I've changed from that to this, but it seems wrong
(setq cider-xrepl-display-in-current-window t)

;; Camel Casing
;; I have mixed feelings about this
(when t (add-hook 'cider-mode-hook 'subword-mode))

;; Use standard clojure-mode faces inside repl:
(setq cider-repl-use-clojure-font-lock t)

;; paredit in nrepl (I'm very torn about this one):
;; No I'm not. Paredit's great for structuring code, but it leaves a lot to be
;; desired in interactive mode.
;; Especially under something like TMUX.
;;(add-hook 'nrepl-mode-hook 'paredit-mode)

(setq nrepl-log-messages t)


;;; Org-mode customizations
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "DELEGATED(g)")
	(sequence "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELLED(c)" "DEFERRED(r)")))
; Mark the timestamp a task completed
(setq org-log-done 'time)

;; Magic key combinations for working inside tmux over ssh
;; put the following line in your ~/.tmux.conf:
;;   setw -g xterm-keys on
(when (getenv "TMUX")
    (progn
      (let ((x 2) (tkey ""))
	(while (<= x 8)
	  ;; shift
	  (if (= x 2)
	      (setq tkey "S-"))
	  ;; alt
	  (if (= x 3)
	      (setq tkey "M-"))
	  ;; alt + shift
	  (if (= x 4)
	      (setq tkey "M-S-"))
	  ;; ctrl
	  (if (= x 5)
	      (setq tkey "C-"))
	  ;; ctrl + shift
	  (if (= x 6)
	      (setq tkey "C-S-"))
	  ;; ctrl + alt
	  (if (= x 7)
	      (setq tkey "C-M-"))
	  ;; ctrl + alt + shift
	  (if (= x 8)
	      (setq tkey "C-M-S-"))

	  ;; arrows
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
	  ;; home
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
	  ;; end
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
	  ;; page up
	  (define-key key-translation-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
	  ;; page down
	  (define-key key-translation-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
	  ;; insert
	  (define-key key-translation-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; delete
	  (define-key key-translation-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; f1
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
	  ;; f2
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
	  ;; f3
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
	  ;; f4
	  (define-key key-translation-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
	  ;; f5
	  (define-key key-translation-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
	  ;; f6
	  (define-key key-translation-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
	  ;; f7
	  (define-key key-translation-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
	  ;; f8
	  (define-key key-translation-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
	  ;; f9
	  (define-key key-translation-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
	  ;; f10
	  (define-key key-translation-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
	  ;; f11
	  (define-key key-translation-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
	  ;; f12
	  (define-key key-translation-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
	  ;; f13
	  (define-key key-translation-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
	  ;; f14
	  (define-key key-translation-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
	  ;; f15
	  (define-key key-translation-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
	  ;; f16
	  (define-key key-translation-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
	  ;; f17
	  (define-key key-translation-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
	  ;; f18
	  (define-key key-translation-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
	  ;; f19
	  (define-key key-translation-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
	  ;; f20
	  (define-key key-translation-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

	  (setq x (+ x 1))))))
