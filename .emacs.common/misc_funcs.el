(defun choose-indent-type ()
  "Counts the indentations with tabs and spaces, and chooses the winner."
  (interactive "")
  (save-excursion
    (goto-char (point-min))
    (let ((tabs 0)
          (spaces 0))
      (while (char-after)
        (let ((char (char-after)))
          (cond ((eq char ?\ )
                 (if (eq (char-after (1+ (point))) ?\ )
                     (setq spaces (1+ spaces))))
                ((eq char ?\t)
                 (setq tabs (1+ tabs))))
          (next-line 1)))
      (if (> tabs spaces)
          (setq indent-tabs-mode t)
        (setq indent-tabs-mode nil)))))



 (defun insert-date ()
   "Inserts the current date at point"
   (interactive)
   (insert (format-time-string "%d/%m/%Y")))
