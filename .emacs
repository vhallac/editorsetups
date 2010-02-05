(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(case-fold-search nil)
 '(column-number-mode t)
 '(compilation-scroll-output t)
 '(current-language-environment "Latin-1")
 '(default-frame-alist (quote ((menu-bar-lines . 1) (width . 85))))
 '(default-gutter-position (quote top))
 '(default-input-method "latin-1-prefix")
 '(default-toolbar-position (quote top))
 '(delete-key-deletes-forward t)
 '(ecb-options-version "2.11")
 '(efs-ftp-program-args (quote ("-L" "-u")))
 '(efs-ftp-prompt-regexp "^.*> *")
 '(efs-use-passive-mode nil)
 '(erc-dcc-get-default-directory "f:\\t")
 '(erc-dcc-listen-host "10.0.0.55")
 '(erc-dcc-mode t)
 '(erc-dcc-verbose t)
 '(erc-modules (quote (autojoin button completion dcc fill irccontrols list match menu move-to-prompt netsplit networks noncommands readonly ring stamp track)))
 '(fast-lock-mode nil t (fast-lock))
 '(fill-column 80)
 '(global-font-lock-mode t nil (font-lock))
 '(gutter-buffers-tab-enabled t)
 '(gutter-buffers-tab-visible-p t)
 '(indent-tabs-mode nil)
 '(initsplit-customizations-alist (quote (("^muse" "~/.emacs.common/muse_init.el" nil) ("^emacs-wiki" "~/.emacs.common/emacs-wiki_init.el" nil) ("^\\(planner\\|remember\\)" "~/.emacs.common/planner_init.el" nil) ("^c-" "~/.emacs.common/c-mode_init.el" nil) ("^svn-" "~/.emacs.common/psvn_init.el" nil) ("^semantic" "~/.emacs.common/cedet_init.el" nil) ("^py-python" "~/.emacs.common/python-mode_init.el" nil) ("^lua" "~/.emacs.common/lua-mode_init.el" nil) ("^\\(epa\\|epg\\)" "~/.emacs.common/epa_init.el" nil) ("^org" "~/.emacs.common/org-mode_init.el" nil))))
 '(initsplit-sort-customizations t)
 '(lazy-lock-mode nil t (lazy-lock))
 '(line-number-mode t)
 '(make-backup-files nil)
 '(message-send-mail-function (quote smtpmail-send-it))
 '(next-line-add-newlines nil)
 '(nxml-slash-auto-complete-flag t)
 '(package-get-always-update t)
 '(paren-mode (quote paren) nil (paren))
 '(pop-up-windows t)
 '(progress-feedback-style (quote small))
 '(require-final-newline t)
 '(sentence-end-double-space nil)
 '(show-paren-mode t nil (paren))
 '(tab-width 4)
 '(tool-bar-mode nil nil (tool-bar))
 '(toolbar-visible-p nil)
 '(transient-mark-mode t)
 '(user-full-name "Vedat Hallac")
 '(user-mail-address "vedathallac@gmail.com"))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:background "#404060" :foreground "white" :height 88 :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(highline-face ((t (:background "grey90")))))
(put 'narrow-to-region 'disabled nil)

(defconst xemacsp (string-match "Lucid\\|XEmacs" emacs-version)

  "Non nil if using XEmacs.") 
; Split customization to multiple files (as customized by
; initsplit-customizations-alist variable)
(load "~/.emacs.common/initsplit.el" t)

; Now, load my goodies.
(load "~/.emacs.common/config.el")

(server-start)

(set-default-coding-systems 'utf-8)
