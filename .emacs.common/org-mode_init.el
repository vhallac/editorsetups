(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)

(custom-set-variables
 '(org-M-RET-may-split-line (quote ((default))))
 '(org-agenda-custom-commands (quote (("D" "Daily Action List" agenda "" ((org-agenda-ndays 1) (org-agenda-sorting-strategy (quote ((agenda time-up priority-down tag-up)))) (org-deadline-warning-days 0))) ("n" "Next actions" todo #("NEXT" 0 4 (face org-warning)) ((org-agenda-sorting-strategy (quote (time-up))))))))
 '(org-agenda-files (quote ("~/org/work.org" "~/org/home.org" "~/org/remember.org")))
 '(org-agenda-include-all-todo t)
 '(org-agenda-time-grid (quote ((daily today) "----------------" (800 1000 1200 1400 1600 1800 2000))))
 '(org-clock-in-resume t)
 '(org-clock-persist t)
 '(org-columns-default-format "%38ITEM(Details) %TAGS(Context) %7TODO(To Do) %5Effort(Estim){:} %6CLOCKSUM{Total}")
 '(org-enforce-todo-checkbox-dependencies t)
 '(org-enforce-todo-dependencies t)
 '(org-global-properties (quote (("Effort_ALL" . "0:0 0:10 0:20 0:30 1:00 2:00 3:00 4:00 8:00"))))
 '(org-log-done (quote time))
 '(org-publish-project-alist (quote (("org-notes-static" :base-directory "~/org/notes" :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf" :publishing-directory "~/org-publish/" :recursive t :publishing-function org-publish-attachment) ("org-notes" :base-directory "~/org/notes" :base-extension "org" :publishing-directory "~/org-publish/") ("org-notes-all" :components ("org-notes" "org-notes-static")))))
 '(org-publish-use-timestamps-flag nil)
 '(org-remember-templates (quote (("TODO" 116 "*TODO %?
   %i
 %a" nil nil nil))))
 '(org-return-follows-link t)
 '(org-special-ctrl-a/e t)
 '(org-use-fast-todo-selection t))
(custom-set-faces)

; Some settings need to be prepared before we load the file.
; So, the position of this is important
(require 'org)
(require 'org-remember)
(require 'org-publish)

(defun home ()
  (interactive)
  (find-file "~/org/home.org"))

(defun work ()
  (interactive)
  (find-file "~/org/work.org"))

(define-key org-mode-map [(control c) (control p)]
    '(lambda ()
       (interactive "")
       (org-publish-current-project)))

(require 'vtidy)

(defun vedat-org-mode-hook ()
  (interactive "")
  (auto-fill-mode t)
  (vtidy-mode 1))

(add-hook 'org-mode-hook 'vedat-org-mode-hook)
