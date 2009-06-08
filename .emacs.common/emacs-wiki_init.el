(require 'emacs-wiki-menu)

(defalias 'wiki 'emacs-wiki-change-project)

(custom-set-variables
 '(emacs-wiki-directories (quote ("~\\Wiki")) nil (emacs-wiki))
 '(emacs-wiki-interwiki-names (quote (("ProjectsWiki" lambda (tag) (emacs-wiki-project-interwiki-link "ProjectsWiki" tag)) ("default" lambda (tag) (emacs-wiki-project-interwiki-link "default" tag)) ("WikiPlanner" lambda (tag) (emacs-wiki-project-interwiki-link "WikiPlanner" tag)))))
 '(emacs-wiki-maintainer "Talk to vedat")
 '(emacs-wiki-menu-bottom "</div>")
 '(emacs-wiki-menu-default "<div class=\"menu\">
       <div style=\"text-align: center;\">Other Places:</div><hr />
       <div class=\"menuitem\"><a href=\"../projects/WelcomePage.html\">Project Notes</a></div>
       <div class=\"menuitem\"><a href=\"../plans/WikiIndex.html\">Plans</a></div>
       <hr />
       <div class=\"menuitem\"><a href=\"http://duff/pcrelease/welcome.asp\">PMS</a></div>
       <div class=\"menuitem\"><a href=\"http://dux/cgi-bin/cvsweb\">CVS view</a></div>
       <div class=\"menuitem\"><a href=\"http://dux/bugzilla/index.cgi\">ET Bugzilla</a></div>
    </div>
")
 '(emacs-wiki-menu-factory (quote emacs-wiki-menu-fixed))
 '(emacs-wiki-menu-top "<div class=\"menu\">
<div style=\"text-align: center;\">Places:</div><hr />")
 '(emacs-wiki-mode-hook (quote (emacs-wiki-use-font-lock (lambda nil (auto-fill-mode (quote t))))))
 '(emacs-wiki-projects (quote (("default" (emacs-wiki-directories "~/Wiki/default") (emacs-wiki-project-server-prefix . "../default/") (emacs-wiki-publishing-directory . "~/EmacsWikiSite/default/")) ("ProjectsWiki" (emacs-wiki-directories "~/Wiki/Projects") (emacs-wiki-project-server-prefix . "../projects/") (emacs-wiki-publishing-directory . "~/EmacsWikiSite/projects/")))))
 '(emacs-wiki-publishing-directory "~/EmacsWikiSite")
 '(emacs-wiki-publishing-footer "</div>
    <!-- Page published by Emacs Wiki ends here -->
    <div class=\"navfoot\">
      <hr />
      <table width=\"100%\" border=\"0\" summary=\"Footer navigation\">
        <col width=\"33%\" /><col width=\"34%\" /><col width=\"33%\" />
        <tr>
          <td align=\"left\">
            <lisp>
              (if emacs-wiki-current-file
                  (concat
                   \"<span class=\\\"footdate\\\">Updated: \"
                   (format-time-string emacs-wiki-footer-date-format
                    (nth 5 (file-attributes emacs-wiki-current-file)))
                   (and emacs-wiki-serving-p
                        (emacs-wiki-editable-p (emacs-wiki-page-name))
                        (concat
                         \" / \"
                         (emacs-wiki-link-href
                          (concat \"editwiki?\" (emacs-wiki-page-name))
                          \"Edit\")))
                   \"</span>\"))
            </lisp>
          </td>
          <td align=\"center\">
            <span class=\"foothome\">
              <lisp>
                (concat
                 (and (emacs-wiki-page-file emacs-wiki-default-page t)
                      (not (emacs-wiki-private-p emacs-wiki-default-page))
                      (concat
                       (emacs-wiki-link-href emacs-wiki-default-page \"Home\")
                       \" / \"))
                 (emacs-wiki-link-href emacs-wiki-index-page \"Index\")
                 (and (emacs-wiki-page-file \"ChangeLog\" t)
                      (not (emacs-wiki-private-p \"ChangeLog\"))
                      (concat
                       \" / \"
                       (emacs-wiki-link-href \"ChangeLog\" \"Changes\"))))
              </lisp>
            </span>
          </td>
          <td align=\"right\">
            <lisp>
              (if emacs-wiki-serving-p
                  (concat
                   \"<span class=\\\"footfeed\\\">\"
                   (emacs-wiki-link-href \"searchwiki?get\" \"Search\")
                   (and emacs-wiki-current-file
                        (concat
                         \" / \"
                         (emacs-wiki-link-href
                          (concat \"searchwiki?q=\" (emacs-wiki-page-name))
                          \"Referrers\")))
                   \"</span>\"))
            </lisp>
          </td>
        </tr>
      </table>
    </div>
  </body>
</html>
")
 '(emacs-wiki-publishing-header "<?xml version=\"1.0\" encoding=\"<lisp>
 (emacs-wiki-transform-content-type
   (or (and (boundp 'buffer-file-coding-system)
            buffer-file-coding-system)
       emacs-wiki-coding-default))</lisp>\"?>
<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">
<html xmlns=\"http://www.w3.org/1999/xhtml\">
  <head>
    <title><lisp>(emacs-wiki-page-title)</lisp></title>
    <meta name=\"generator\" content=\"emacs-wiki.el\" />
    <meta http-equiv=\"<lisp>emacs-wiki-meta-http-equiv</lisp>\"
          content=\"<lisp>emacs-wiki-meta-content</lisp>\" />
    <link rel=\"made\" href=\"<lisp>emacs-wiki-maintainer</lisp>\" />
    <link rel=\"home\" href=\"<lisp>(emacs-wiki-published-name
                                     emacs-wiki-default-page)</lisp>\" />
    <link rel=\"index\" href=\"<lisp>(emacs-wiki-published-name
                                      emacs-wiki-index-page)</lisp>\" />
    <lisp>emacs-wiki-style-sheet</lisp>
  </head>
  <body>

    <lisp>(when (boundp 'emacs-wiki-menu-factory)
            (funcall emacs-wiki-menu-factory))</lisp>
    <div class=\"content\">
    <h1 id=\"top\"><lisp>(emacs-wiki-page-title)</lisp></h1>

    <!-- Page published by Emacs Wiki begins here -->
")
 '(emacs-wiki-style-sheet "<link rel=\"stylesheet\" type=\"text/css\" href=\"../style.css\" />")
 '(emacs-wiki-update-project-hook (quote (planner-update-wiki-project emacs-wiki-update-project-interwikis))))
(custom-set-faces)
