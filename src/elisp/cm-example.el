;;; cm-example.el ---

;; Version: 0.1
;; Package-Requires: ((clomacs "0.0.5"))

(require 'clomacs)

(clomacs-defun cm-example-set-emacs-connection
               clomacs/set-emacs-connection
               :lib-name "cm-test")
(clomacs-defun cm-example-close-emacs-connection
               clomacs/close-emacs-connection
               :lib-name "cm-test")
(clomacs-defun cm-example-require
               clojure.core/require
               :lib-name "cm-test")

(defun cm-example-httpd-start ()
  (cl-flet ((clomacs-set-emacs-connection 'cm-example-set-emacs-connection)
            (clomacs-require 'cm-example-require))
    (clomacs-httpd-start)))

(defun cm-example-httpd-stop ()
  (cl-flet ((clomacs-close-emacs-connection 'cm-example-close-emacs-connection)
            (clomacs-require 'cm-example-require))
    (clomacs-httpd-stop)))

(clomacs-defun cm-example-md-to-html-wrapper
               my-md-to-html-string
               :namespace cm-test.core
               :lib-name "cm-test"
               :doc "Convert markdown to html via clojure lib.")

(defun cm-example-mdarkdown-to-html (beg end)
  "Add to the selected markdown text it's html representation."
  (interactive "r")
  (save-excursion
    (if (< (point) (mark))
        (exchange-point-and-mark))
    (insert
     (concat "\n" (cm-example-md-to-html-wrapper
                   (buffer-substring beg end))))))

(clomacs-defun cm-example-strong-emacs-version
               strong-emacs-version
               :namespace cm-example.core
               :lib-name "cm-test"
               :doc "Get Emacs version with markdown strong marks."
               :httpd-starter 'cm-example-httpd-start)

(defun cm-ert-example ()
  "cm-ert-example")

;; (cm-test-httpd-start)
;; (add-to-list 'load-path "~/.emacs.d/cm-test/src/elisp/")
;; (require 'cm-example)
;; (cm-test-md-to-html-wrapper "# This is a test")
;; # This is a test
;; (cm-test-md-to-html-wrapper (cm-test-strong-emacs-version))

(provide 'cm-example)

;;; cm-example.el ends here
