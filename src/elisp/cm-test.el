;;; cm-test.el ---

;; Version: 0.1

(require 'clomacs)

(clomacs-defun cm-test-set-emacs-connection
               clomacs/set-emacs-connection
               :lib-name "cm-test")
(clomacs-defun cm-test-close-emacs-connection
               clomacs/close-emacs-connection
               :lib-name "cm-test")
(clomacs-defun cm-test-require
               clojure.core/require
               :lib-name "cm-test")

(defun cm-test-httpd-start ()
  (cl-flet ((clomacs-set-emacs-connection 'cm-test-set-emacs-connection)
            (clomacs-require 'cm-test-require))
    (clomacs-httpd-start)))

(defun cm-test-httpd-stop ()
  (cl-flet ((clomacs-close-emacs-connection 'cm-test-close-emacs-connection)
            (clomacs-require 'cm-test-require))
    (clomacs-httpd-stop)))

(clomacs-defun cm-test-md-to-html-wrapper
               my-md-to-html-string
               :namespace cm-test.core
               :lib-name "cm-test"
               :doc "Convert markdown to html via clojure lib.")

(defun cm-test-mdarkdown-to-html (beg end)
  "Add to the selected markdown text it's html representation."
  (interactive "r")
  (save-excursion
    (if (< (point) (mark))
        (exchange-point-and-mark))
    (insert
     (concat "\n" (cm-test-md-to-html-wrapper
                   (buffer-substring beg end))))))

(clomacs-defun cm-test-strong-emacs-version
               strong-emacs-version
               :namespace cm-test.core
               :lib-name "cm-test"
               :doc "Get Emacs version with markdown strong marks."
               :httpd-starter 'cm-test-httpd-start)

(provide 'cm-test)

;; (cm-test-httpd-start)
;; (add-to-list 'load-path "~/.emacs.d/cm-test/src/elisp/")
;; (require 'cm-test)
;; (cm-test-md-to-html-wrapper "# This is a test")
;; # This is a test
;; (cm-test-md-to-html-wrapper (cm-test-strong-emacs-version))

;;; cm-test.el ends here
