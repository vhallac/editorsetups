(require 'lua-mode)

(custom-set-variables
 '(lua-default-application "f:\\tools\\wow-lua\\lua-wow.exe"))
(custom-set-faces)

(add-hook 'lua-mode-hook '(lambda ()
  "Make the ASM mode easier to live with"
  (choose-indent-type)
  (setq lua-indent-level 4)
  (vtidy-mode 't)))
