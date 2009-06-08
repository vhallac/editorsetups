(add-hook 'asm-mode-hook '(lambda ()
  "Make the ASM mode easier to live with"
  (make-local-variable 'indent-line-function)
  (defcustom asm-mode-indent-column 8
    "Indentation column for instructions"
    :type 'integer
    :group 'asm)
  (setq indent-line-function
        '(lambda ()
           (save-excursion
             (indent-to-left-margin)
             (if (not (search-forward "EQU" (point-at-eol) t))
                 (indent-to-column asm-mode-indent-column)))
           (let ((pos (current-indentation)))
             (if (< (current-column) pos)
                 (move-to-column pos)))))
  (define-key asm-mode-map "\t" 'indent-according-to-mode)
  (define-key asm-mode-map [(meta l)] '(lambda ()
                                         (interactive)
                                         (indent-to-left-margin)
                                         (goto-char (point-at-eol))
                                         (newline)
                                         (indent-according-to-mode)))
  (vtidy-mode 't)))
