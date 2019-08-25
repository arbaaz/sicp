
(defun main()
  (let ((x (read-line)))
    (coerce (mu (coerce x 'list)) 'string))
  )


(defun mu (input)
  (cond ((eq (cadr input) #\i) (append input '(#\u))))
  )

(main)
(mu '(#\m #\i))
