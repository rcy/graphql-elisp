(defun graphql-request (endpoint query &optional variables)
  (let* ((url-request-method "POST")
         (url-request-extra-headers '(("Content-Type" . "application/json")))
         (url-request-data
          (json-encode (list (cons "query" query)
                             (cons "variables" (and variables (json-encode variables))))))
         (buffer (url-retrieve-synchronously endpoint)))
    (with-current-buffer buffer
      (goto-char url-http-end-of-headers)
      (let ((json-object-type 'hash-table))
        (json-read)))))
