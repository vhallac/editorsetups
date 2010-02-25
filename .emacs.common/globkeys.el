; Useful global keymap bindings
(define-key global-map [(control tab)] 'other-window)
(define-key global-map [(control f6)] 'bury-buffer)
(define-key global-map [(end)] 'end-of-line)
(define-key global-map [(home)] 'beginning-of-line)
(define-key global-map [(control end)] 'end-of-buffer)
(define-key global-map [(control home)] 'beginning-of-buffer)
(define-key global-map [(control j)] 'delete-indentation)
(define-key global-map [(control W)] 'delete-region)
(define-key global-map [(meta g)] 'goto-line)
(define-key global-map [(meta f1)] 'cvs-conflict-first)
(define-key global-map [(meta f2)] 'cvs-conflict-second)
(define-key global-map [(f9)] '(lambda () "Choose buffer"
                                 (interactive "")
                                 (electric-buffer-list)))
(define-key global-map (kbd "M-]") 'match-parenthesis)

; For console:
; Will add to this list as I encounter more mismatches
(if window-system
    ; Alias C-/ in window mode to C-_
    (progn
      (define-key key-translation-map (kbd "C-/") (kbd "C-_")))
  ; Fixup missing console keys
  (define-key key-translation-map (kbd "M-[ 1 ^") (kbd "C-<home>"))
  (define-key key-translation-map (kbd "<select>") (kbd "<end>"))
  (define-key key-translation-map (kbd "M-[ 4 ^") (kbd "C-<end>")))

; The helper functions for the global key bindings

(defun cvs-conflict-first ()
  "Removes the second part of the next conflict.
The cursor must be placed BEFORE the conflict start."
  (interactive)
  (search-forward "<<<<<<< ")
  (kill-entire-line)
  (search-forward "=======")
  (kill-entire-line)
  (let ((start-of-delete (point-marker)))
	(search-forward ">>>>>>> ")
	(kill-entire-line)
	(delete-region start-of-delete (point-marker)))
  (search-forward "<<<<<<< ")
  (beginning-of-line)
)

(defun cvs-conflict-second ()
  "Removes the first part of the next conflict.
The cursor must be placed BEFORE the conflict start."
  (interactive)
  (search-forward "<<<<<<< ")
  (kill-entire-line)
  (let ((start-of-delete (point-marker)))
	(search-forward "=======")
	(kill-entire-line)
	(delete-region start-of-delete (point-marker)))
  (search-forward ">>>>>>> ")
  (kill-entire-line)
  (search-forward "<<<<<<< ")
  (beginning-of-line)
)

(defun match-parenthesis (arg)
  "Match the current character according to the syntax table.

   Based on the freely available match-paren.el by Kayvan Sylvan.
   I merged code from goto-matching-paren-or-insert and match-it.

   You can define new \"parentheses\" (matching pairs).
   Example: angle brackets. Add the following to your .emacs file:

   	(modify-syntax-entry ?< \"(>\" )
   	(modify-syntax-entry ?> \")<\" )

   You can set hot keys to perform matching with one keystroke.
   Example: f6 and Control-C 6.

   	(global-set-key \"\\C-c6\" 'match-parenthesis)
   	(global-set-key [f6] 'match-parenthesis)

   Simon Hawkin <cema@cs.umd.edu> 03/14/1998"
  (interactive "p")
  ;;The ?= can be anything that is not a ?\(or ?\)
  (let ((syntax (char-syntax (or (char-after) ?=)))
        (syntax2 (char-syntax (or (char-before) ?=))))
    (cond
     ((= syntax ?\()
      (forward-sexp 1) (backward-char))
     ((= syntax ?\))
      (forward-char) (backward-sexp 1))
     ((= syntax2 ?\()
      (backward-char) (forward-sexp 1) (backward-char))
     ((= syntax2 ?\))
      (backward-sexp 1))
     (t (message "No match")))))
