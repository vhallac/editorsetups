; Split customization to multiple files (as customized by
; initsplit-customizations-alist variable)
(load "~/.emacs.common/initsplit.el" t)
; Load the config file
(load "~/.emacs.common/config.el")
