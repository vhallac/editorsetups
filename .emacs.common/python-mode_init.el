(require 'python)

(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(autoload 'python-mode "python-mode" "Python editing mode." t)

;(custom-set-variables
; '(py-python-command "c:\\python26\\python.exe"))
(custom-set-faces)

(defun ropemacs-start ()
  "Loads pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil))

(defun pylons-start ()
  (interactive)
  (set (make-local-variable 'python-command) "c:\\pylons\\Scripts\\python.exe"))
