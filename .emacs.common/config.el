; The few macros below make it easier to code up version dependent stuff
(defmacro GNUEmacs (&rest x)
  (list 'if (string-match "GNU Emacs" (prin1-to-string (version))) (cons 'progn x)))
(defmacro GNUEmacs20 (&rest x)
  (list 'if (string-match "GNU Emacs 20" (prin1-to-string (version))) (cons 'progn x)))
(defmacro GNUEmacs21 (&rest x)
  (list 'if (string-match "GNU Emacs 21" (prin1-to-string (version))) (cons 'progn x)))
(defmacro XEmacs (&rest x)
  (list 'if (string-match "XEmacs 21" (prin1-to-string (version))) (cons 'progn x)))
(defmacro GNULinux (&rest x)
  (list 'if (string-match "linux" (prin1-to-string system-type)) (cons 'progn x)))
(defmacro Windows (&rest x)
  (list 'if (string-match "windows" (prin1-to-string system-type)) (cons 'progn x)))

; Make sure we get to edit a file. Even if some packages are missing.
(defmacro try-progn (err-msg &rest body)
  `(condition-case err
      ,@body
    (error (message-box (concat ,err-msg " %s.") (cdr err)))))

; Compatibility macros for Emacs/XEmacs. I have just enough to cover my bits in
; this directory.
(XEmacs
 (defun subst-char-in-string (C1 C2 STR)
   (substitute C2 C1 STR)))

(GNUEmacs
 ;From locate.el locate-current-line-number
 (defun line-number ()
   "Return the current line number in current buffer."
   (+ (count-lines (point-min) (point))
      (if (eq (current-column) 0)
          1
        0)))
 (defun int-to-char (X) X)
 (defun set-buffer-tag-table (FILE)
   (visit-tags-table FILE t)))

; Default frame position
(if window-system
    (progn 
      (XEmacs
       (set-frame-position nil 0 0)
       (set-frame-height nil 58))
      (GNUEmacs
       (Windows
        (setq initial-frame-alist (append '((top . 20) (left . 1))
                                          (if (>= (x-display-pixel-height) 1024)
                                              (list (cons 'height 55))))))
       (GNULinux
        (if (>= (x-display-pixel-height) 1024)
            (setq initial-frame-alist '((height . 55))))))))

(defun recursive-directory-list (path)
  (let* ((toplevel (directory-files path t))
         (dirs nil))
    (while toplevel
      (let ((file (car toplevel)))
        (unless (member
                 (file-name-nondirectory file)
                 '("." ".." "cvs" "CVS" "rcs" "RCS" ".svn" "emacs" "xemacs"))
          (if (file-directory-p file)
              (setq dirs (append dirs
                                 (recursive-directory-list file)))))
        (setq toplevel (cdr toplevel))))
    (setq dirs (append dirs (list path)))))

; Add the packages in .emacs.common to load path. Make my packages preferred.
(setq load-path (append (recursive-directory-list "~/.emacs.common/packages")
                        load-path))

; Required packages, and other configuration files
(try-progn "Cannot load completion package"
           (require 'completion))

(try-progn "Cannot load the pabbrev package"
           (require 'pabbrev)
           (global-pabbrev-mode 1))

; No longer needed. c-subword-mode handles things just fine
; (try-progn "Cannot load the CamelCase extension package"
;           (require 'camelCase "camelCase-mode.el"))

(try-progn "Cannot load misc setup functions"
           (load "~/.emacs.common/misc_funcs.el"))

(try-progn "Cannot set up paths"
           (load "~/.emacs.common/paths.el"))

(try-progn "Cannot initialize psvn"
           (load "~/.emacs.common/psvn_init.el"))

(try-progn "Cannot set up C environment"
           (load "~/.emacs.common/c-mode_init.el"))

(try-progn "Cannot set up assembler environment"
           (load "~/.emacs.common/asm-mode_init.el"))

(try-progn "Cannot set up python environment"
           (load "~/.emacs.common/python-mode_init.el"))

(try-progn "Cannot install global keymap"
           (load "~/.emacs.common/globkeys.el"))

(try-progn "Cannot set up nXML mode"
           (load "~/.emacs.common/nxml-mode_init.el"))

(try-progn "Cannot set up lua mode"
           (load "~/.emacs.common/lua-mode_init.el"))

(try-progn "Cannot set up EPA/EPG"
           (load "~/.emacs.common/epa_init.el"))

(try-progn "Cannot set up ORG mode"
           (load "~/.emacs.common/org-mode_init.el"))

(try-progn "In windows, and cannot set up the planner package"
           ; Planner and wiki only on my dev box
           (if (eq system-type 'windows-nt)
               (load "~/.emacs.common/planner_init.el")))

; Lazy mode on: Type y or n instead of full "yes" or "no"
(fset 'yes-or-no-p 'y-or-n-p)

(GNUEmacs
 (GNULinux
  (normal-erase-is-backspace-mode 1)))

(Windows
 (setq tramp-default-method "plink"))

; Experimental setup extras
(GNUEmacs
 (scroll-bar-mode -1)
 (blink-cursor-mode -1)
 (setq transient-mark-mode t)
 (menu-bar-mode -1)
 (tool-bar-mode -1)

 ;; no splash screen:
 (setq inhibit-startup-message t)
 (setq inhibit-splash-screen t)

 ;; Interactively do things
 (ido-mode t))
