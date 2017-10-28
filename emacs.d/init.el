;;; Auto-customized pieces

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frame-background-mode (quote light))
 '(indent-tabs-mode nil)
 '(rainbow-delimiters-max-face-count 1)
 '(safe-local-variable-values
   (quote
    ((cider-boot-parameters . "cider repl -s ...others... wait"))))
 '(tab-width 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((t (:foreground "blue"))))
 '(font-lock-comment-face ((t (:foreground "medium blue"))))
 '(font-lock-constant-face ((t (:foreground "red"))))
 '(font-lock-function-name-face ((t (:foreground "medium blue"))))
 '(font-lock-keyword-face ((t (:foreground "tomato"))))
 '(font-lock-string-face ((t (:foreground "sandy brown"))))
 '(font-lock-type-face ((t (:foreground "midnight blue"))))
 '(font-lock-variable-name-face ((t (:foreground "light sea green"))))
 '(link ((t (:foreground "deep sky blue" :underline t))))
 '(org-date ((t (:foreground "black" :underline t))))
 '(org-level-3 ((t (:inherit outline-3 :foreground "brightmagenta"))))
 '(org-level-4 ((t (:inherit nil :foreground "color-54"))))
 '(shadow ((t (:foreground "dim gray"))))
 '(web-mode-doctype-face ((t (:foreground "green"))))
 '(web-mode-html-attr-name-face ((t (:foreground "blue"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "brightblack"))))
 '(web-mode-html-tag-face ((t (:foreground "brightblack")))))


;;; Take a look at http://www.cs.utah.edu/~aek/code/init.el.html
;;; There are some interesting-looking settings in there.

;;; This is getting complicated enough that it seems like it just
;;; might be worth breaking into multiple modules to help with
;;; startup time.
;;; Probably Better: Don't have so many instances!
;;; How's that work with multiple clojure projects/REPLs?

(electric-indent-mode +1)

;;; Package Management.
;; There are interesting debates about marmalade vs. melpa.
;; These days, there don't seem to be any significant reasons
;; to not include both
(setq package-enable-at-startup nil)
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(if (> emacs-major-version 23)
    (require 'package)
  ;; Q: How do I produce a warning?
  ;; At the very least, magit won't work
  ) ;;; TODO: Verify that we're on emacs 24

;; Apparently I want this if I'm going to be running
;; package-initialize myself
(setq package-enable-at-startup nil)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(cider
                      clojure-mode
                      clojurescript-mode
                      ;;kibit-helper  ; Q: Do I really want this?
                      magit
                      paredit
                      ;; Proationary mode, to try out only highlighting mismatched parens
                      rainbow-delimiters
                      slamhound
                      web-mode))
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;;; Luddite Mode
(cond ((> emacs-major-version 20)
       ;; Text version doesn't have these modes
       (tool-bar-mode -1)  ; intro'd in emacs 21
       (scroll-bar-mode -1)
       (menu-bar-mode -1)
       (menu-bar-showhide-fringe-menu-customize-disable)
       (blink-cursor-mode -1)
       ;; Q: What's this next line do?
       (windmove-default-keybindings 'meta)))
;; Toggles luddite mode
(global-set-key [f12] '(lambda ()
			 (interactive)
			 (menu-bar-mode nil)
			 (scroll-bar-mode nil)))
(defun toggle-mode-line ()
  "Toggles the modeline on and off"
  (interactive)
  (setq mode-line-format
	(if (equal mode-line-format nil)
	    (default-value 'mode-line-format)))
  (redraw-display))
(global-set-key [M-f12] 'toggle-mode-line)

;;;; Clojure

(add-to-list 'auto-mode-alist '("\.cljs$" . clojurescript-mode))
(add-to-list 'auto-mode-alist '("\.cljx$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\.cljc$" . clojurec-mode))
(add-to-list 'auto-mode-alist '("\.pxi$" . clojure-mode))

;;; paredit
(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'clojurescript-mode-hook #'enable-paredit-mode)
(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Experimental settings that I ran across in a recent blog post

;;; Rainbow Delimiters (experimental, but I already think I approve)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
(require 'rainbow-delimiters)
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                    :foreground 'unspecified
                    :inherit 'error)

;;; Auto-save when losing focus
;;; e.g. switching from here to a browser for figwheel
(defun tim-pratley/save-all ()
  (interactive)
  (save-some-buffers t))
(add-hook 'focus-out-hook 'tim-pratley/save-all)

;;; sexp transposition (experimental)
(defun noprompt/forward-transpose-sexps ()
  (interactive)
  (transpose-sexps 1)
  (paredit-backward))
(defun noprompt/backward-transpose-sexps ()
  (interactive)
  (transpose-sexps 1)
  (paredit-backward)
  (paredit-backword))
;; Q: How do I want to activate these?
;; The article I'm borrowing this from uses
;; But that involves also installing the key-chord package.
;; Q: Do I want that?
;; A: Nope.
(when nil
  (key-chord-define-global "tk" 'noprompt/forward-transpose-sexps)
  (key-chord-define-global "tj" 'noprompt/backward-transpose-sexps))

;; Use figwheel
;; Or maybe not, if I'm switching everything interesting to boot
(when nil
  (setq cider-cljs-lein-repl "(do (use 'figwheel-sidecar.repl.api)
    (start-figwheel!)
    (cljs-repl))"))


;; Send expression directly to REPL buffer (experimental)
;; It'll be interesting to see how this works out in practice, with
;; multiple REPL connections
;; Also experimental
(defun tim-pratley/cider-eval-expression-at-point-in-repl ()
  (interactive)
  (let ((form (cider-defun-at-point)))
    ;; Strip excess whitespace
    (while (string-match "\\`\s+\\|\n+\\'" form)
      (setq form (replace-match "" t t form)))
    (set-buffer (cider-get-repl-buffer))
    (goto-char (point-max))
    (insert form)
    (cider-repl-return)))
(require 'cider-mode)
(define-key cider-mode-map
  (kbd "C-;") 'tim-pratley/cider-eval-expression-at-point-in-repl)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; End of that experimental block

;;; eldoc
(require 'eldoc)
(eldoc-add-command
  'paredit-backward-delete
  'paredit-close-round)

;; Recommendations from the nrepl README:
;; eldoc (shows the args to whichever function you're calling):
(add-hook 'cider-interaction-mode-hook
          'eldoc-mode)
(add-hook 'cider-mode-hook 'eldoc-mode)

;; turn off auto-complete with tab
; (it recommends using M-tab instead)
(setq cider-tab-command 'indent-for-tab-command)
(setq cider-repl-tab-command 'indent-for-tab-command)

;; Make C-c C-z switch to *cider repl* in current window:
(when nil (setq cider-repl-display-in-current-window t))
;; I've changed from that to this, but it seems wrong
(setq cider-xrepl-display-in-current-window t)

;; Camel Casing
(add-hook 'cider-mode-hook 'subword-mode)

;; Use standard clojure-mode faces inside repl:
(setq cider-repl-use-clojure-font-lock t)

;; paredit in nrepl (I'm very torn about this one):
;; No I'm not. Paredit's great for structuring code, but it leaves a lot to be
;; desired in interactive mode.
;; Especially under something like TMUX.
;;(add-hook 'nrepl-mode-hook 'paredit-mode)

(setq nrepl-log-messages t)

;;; Javascript
(defun jrg-customize-javascript-mode ()
  (setq indent-tabs-mode t)
  (setq tab-width 4))
;; Q: Do I need to #' this or not?
;; TODO: Check against the version where I actually muck around with javascript
(add-hook 'js-mode-hook 'jrg-customize-javascript-mode)

;;; Org-mode customizations
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d)" "DELEGATED(g)")
	(sequence "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELLED(c)" "DEFERRED(r)")))
; Mark the timestamp a task completed
(setq org-log-done 'time)

;; capture
(setq org-default-notes-file "~/projects/todo/notes.org")
(define-key global-map "\C-cn" 'org-capture)

;; Allow clojure code blocks in org mode
(require 'org)
(require 'ob-clojure)
(setq org-babel-clojure-backend 'cider)
(when nil (require 'cider))

;;; Web Mode
;;; (the super-primitive/I-haven't-watched-intro-video version)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; Keep around for copy/pasting future file extensions
(when nil (add-to-list 'auto-mode-alist '("\\.\\'" . web-mode)))
;; No idea what this might be for
;; TODO: Actually read the basics on web-mode.org
(setq web-mode-engines-alist
      '(("php"   . "\\.phtml\\'")
        ("blade" . "\\.blade\\.")))

;;; Some conveniences
(when nil
  ;; These are set in variables at the top
  ;; Q: How do I overwrite this for javascript mode?
  (setq-default indent-tabs-mode nil)
  (setq tab-width 4))
(setq default-buffer-file-coding-system 'utf-8-unix)
(define-coding-system-alias 'UTF-8 'utf-8)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; htmlize
;; TODO: How do I use external CSS?
(autoload 'htmlize-buffer "htmlize"
  "Convert buffer to HTML, preserving colors and decorations." t)

;;; slime
;(load (expand-file-name "~/quicklisp/slime-helper.el"))
;(setq inferior-lisp-program "ccl")
;(load "~/quicklisp/log4slime-setup.el")
;(global-log4slime-mode 1)

(when nil (require 'tramp))
(setq tramp-default-method "ssh")
;; I'm pretty sure this worked on xubuntu.
;; Q: Why isn't it working on Loki?
;; Hmm...I'm running emacs24 on the former, and 25 on the latter.
(add-to-list 'tramp-remote-path 'tramp-own-remote-path)
(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

;;; Ruby On Rails

(when nil
  ;; Rake files are ruby too, as are gemspecs, rackup files, and gemfiles
  (add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
  (add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode)))

;; Never want to edit bytecode
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".pyc")

;; HAML...although the haml mode seems broken
(when nil
  (add-hook 'haml-mode-hook
            (lambda ()
              (setq indent-tabs-mode nil)
              (define-key haml-mode-map "\C-m" 'newline-and-indent))))

;;; Markdown Mode
;; Q: Do I need this?
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Magic key combinations for working inside tmux over ssh
;; put the following line in your ~/.tmux.conf:
;;   setw -g xterm-keys on

;; Configuration customizations for running under tmux
;; Found @
;; http://unix.stackexchange.com/questions/24414/shift-arrow-not-working-in-emacs-within-tmux
;; Seems to be needed when .tmux.conf includes
;; setw -g xterm-keys on
;; N.B. to get a hint about which key sequence your terminal
;; is sending, use C-q <chord>
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
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))
	  ;; home
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
	  ;; end
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
	  ;; page up
	  (define-key key-translation-map
	    (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey)))
	  ;; page down
	  (define-key key-translation-map
	    (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey)))
	  ;; insert
	  (define-key key-translation-map
	    (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; delete
	  (define-key key-translation-map
	    (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))
	  ;; f1
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
	  ;; f2
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
	  ;; f3
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
	  ;; f4
	  (define-key key-translation-map
	    (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
	  ;; f5
	  (define-key key-translation-map
	    (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
	  ;; f6
	  (define-key key-translation-map
	    (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
	  ;; f7
	  (define-key key-translation-map
	    (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
	  ;; f8
	  (define-key key-translation-map
	    (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
	  ;; f9
	  (define-key key-translation-map
	    (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
	  ;; f10
	  (define-key key-translation-map
	    (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
	  ;; f11
	  (define-key key-translation-map
	    (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
	  ;; f12
	  (define-key key-translation-map
	    (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
	  ;; f13
	  (define-key key-translation-map
	    (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
	  ;; f14
	  (define-key key-translation-map
	    (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
	  ;; f15
	  (define-key key-translation-map
	    (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
	  ;; f16
	  (define-key key-translation-map
	    (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
	  ;; f17
	  (define-key key-translation-map
	    (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
	  ;; f18
	  (define-key key-translation-map
	    (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
	  ;; f19
	  (define-key key-translation-map
	    (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
	  ;; f20
	  (define-key key-translation-map
	    (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

	  (setq x (+ x 1))))))
