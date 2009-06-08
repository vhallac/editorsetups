
(require 'muse-project)
(require 'muse-wiki)
(require 'muse-html)

(custom-set-variables
 '(muse-file-extension nil)
 '(muse-html-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />")
 '(muse-project-alist (quote (("PlannerWiki" ("~/Wiki/Plans" :default "index" :major-mode planner-mode :visit-link planner-visit-link)) ("PojectsWiki" ("~/Wiki/Projects" :default "WelcomePage") (:base "xhtml" :path "~/MuseWikiSite/projects")))))
 '(muse-xhtml-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />"))
(custom-set-faces)

(setq muse-mode-auto-p t)
;(add-hook 'find-file-hooks 'muse-mode-maybe)
