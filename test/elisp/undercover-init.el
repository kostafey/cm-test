(when (require 'undercover nil t)
  (setq undercover-force-coverage t)
  (undercover "src/elisp/*.el"
	          (:report-format 'lcov)
              (:merge-report nil)
	          (:send-report nil)))
