(require 'lua-mode)

(custom-set-variables
 '(lua-default-application "f:\\tools\\wow-lua\\lua-wow.exe"))
(custom-set-faces)

(add-hook 'lua-mode-hook '(lambda ()
  "Customizations for lua mode"
  (setq lua-electric-mode nil) ; Can't indent properly. At stay out of the way.
  (choose-indent-type)
  (setq lua-indent-level 4)
  (choose-indent-type)
  (vtidy-mode 't)))
