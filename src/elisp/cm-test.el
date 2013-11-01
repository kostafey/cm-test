(require 'clomacs)

(clomacs-defun cm-test-md-to-html-wrapper
               cm-test.core/my-md-to-html-string
               :lib-name "cm-test"
               :namespace "cm-test.core"
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

(provide 'cm-test)

;; (add-to-list 'load-path "~/.emacs.d/cm-test/src/elisp/")
;; (require 'cm-test)
;; (clomacs-print-cp)
;; (cm-test-md-to-html-wrapper "# This is a test")
;; # This is a test

