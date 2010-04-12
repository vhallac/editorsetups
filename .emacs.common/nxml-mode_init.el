;;--
;; Make sure nxml-mode can autoload
;;--
;;(load "rng-auto.el")

;;--
;; Load nxml-mode for files ending in .xml, .xsl, .rng, .xhtml
;;--
(add-to-list 'auto-mode-alist
             '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\|html\\|htm\\)\\'" . nxml-mode))

(custom-set-variables
 '(nxml-slash-auto-complete-flag t)
 '(rng-schema-locating-files (quote ("schemas.xml" "~/.emacs.common/data/schema/schemas.xml"))))
(custom-set-faces)
