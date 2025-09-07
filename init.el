(require 'package)
(setq package-archives '(("elpa" . "http://tromey.com/elpa/")
                         ("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(ignored-local-variable-values
   '((languagetool-local-disabled-rules
      "MISSING_COMMA_AFTER_INTRODUCTORY_PHRASE" "WHITESPACE_RULE"
      "CONSECUTIVE_SPACES" "CONSECUTIVE_SPACES" "WHITESPACE_RULE"
      "CURRENCY" "CURRENCY" "COMMA_PARENTHESIS_WHITESPACE" "CURRENCY"
      "COMMA_PARENTHESIS_WHITESPACE" "CURRENCY" "CURRENCY" "CURRENCY"
      "ENGLISH_WORD_REPEAT_RULE" "COMMA_PARENTHESIS_WHITESPACE"
      "COMMA_PARENTHESIS_WHITESPACE" "WHITESPACE_RULE"
      "COMMA_PARENTHESIS_WHITESPACE" "COMMA_PARENTHESIS_WHITESPACE" n
      "WHITESPACE_RULE" "NON_STANDARD_WORD" "CURRENCY" "CURRENCY"
      "SPACE_BETWEEN_NUMBER_AND_WORD" "COMMA_PARENTHESIS_WHITESPACE"
      "COMMA_PARENTHESIS_WHITESPACE" "COMMA_PARENTHESIS_WHITESPACE"
      "COMMA_PARENTHESIS_WHITESPACE" "CURRENCY"
      "COMMA_PARENTHESIS_WHITESPACE" "COMMA_PARENTHESIS_WHITESPACE")))
 '(package-selected-packages
   '(auctex ellama haskell-mode helm-bibtex ivy-bibtex languagetool llm
	    markdown-mode markdown-preview-mode org-roam org-roam-ui
	    pdf-tools plz plz-event-source proof-general))
 '(safe-local-variable-values
   '((bibtex-completion-bibliography "./Complexity.bib")
     (reftex-default-bibliography "./Complexity.bib"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
'(region ((t (:background "LightGoldenrod2" :foreground "black"))))
 '(hl-line ((t (:background "gray20"))))
 )
(load "~/.emacs.d/pdf.el")
;;(load "~/.emacs.d/languagetool.el")
(defun g++-compile-and-run ()
  (interactive)
  (compile (format "g++ -std=c++20 %s -o run && ./run" (buffer-file-name))))

(defun test-code ()
  (interactive)
  (shell-command "tt"))

(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '(".md" . markdown-mode) auto-mode-alist))

(setq markdown-open-command "/snap/bin/firefox")

(global-display-line-numbers-mode t)
(global-set-key (kbd "<f5>") 'g++-compile-and-run)
(global-set-key (kbd "<f7>") 'test-code)
(put 'upcase-region 'disabled nil)

(use-package ellama
  :ensure t
  :bind ("C-c e" . ellama-transient-main-menu)
  ;; send last message in chat buffer with C-c C-c
  :hook (org-ctrl-c-ctrl-c-final . ellama-chat-send-last-message)
  :init
  (setopt ellama-auto-scroll t)
  (setopt ellama-keymap-prefix "C-c e")
  :config
  ;; show ellama context in header line in all buffers
  (ellama-context-header-line-global-mode +1))

;;bibtex
(use-package helm-bibtex
  :ensure t
  :bind ("C-c b" . helm-bibtex)  ;; 设置快捷键
  :config
  (setq helm-bibtex-cite-default-command "cite"  ;; 设置默认插入的引用命令
        helm-bibtex-cite-commands '("cite" "parencite" "textcite")))


(use-package auctex
  :ensure t
  :no-require t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (setq-default TeX-engine 'xetex)
  ;;(setq TeX-PDF-mode t)
  ;(with-eval-after-load 'tex-mode
    ;; "latexmk -shell-escape -bibtex -xelatex -g -f %f"
    ;(add-to-list 'tex-compile-commands '("xelatex --synctex=1 %f" t "%r.pdf"))
    ;(add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))
    ;(setq TeX-command-default "xelatex"))

  (setq TeX-show-compilation t)
  ;; [ SyncTeX ] -- Sync (forward and inverse search) PDF with TeX/LaTeX.
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-method 'synctex) ; default
  ;; [C-c C-g] switch between LaTeX source code and PDF positions.
  (setq TeX-source-correlate-start-server t)
  ;(TeX-source-correlate-mode t)
  ;; update PDF buffers after successful LaTeX runs.
  (add-hook 'TeX-after-TeX-LaTeX-command-finished-hook #'TeX-revert-document-buffer))

;; fullscreen frame
(add-to-list 'default-frame-alist '(fullscreen . maximized))

(global-hl-line-mode 1)
