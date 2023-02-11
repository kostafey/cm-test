(add-to-list 'load-path "src/elisp/")
(load-file "./test/elisp/undercover-init.el")
(require 'cm-example)

(ert-deftest cm-basic-test ()
  (should (equal 1 1))
  (should (equal (cm-ert-example) "cm-ert-example")))
