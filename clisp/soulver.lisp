(defun read-input ()
  (let ((input (read-from-string (concatenate 'string "(" (read-line) ")"))))
    (let ((cmd (parse-cmd input)))
      (eval-input cmd)
      )
    )
  )


(defun parse-cmd (cmd)
  (let ((x (mapcar #'santize-cmd cmd)))
    ;(print x)
    (evalution-order x))
  )

(defun santize-cmd (op)
  (case op
    ('and 'add)
    ('less 'sub)
    ('from 'rsub)
    ('of 'mul)
    ('at 'mul)
    ('by 'mul)
    ('over 'div)
    ('per 'div)
    (t op)
    )
  )

(subseq '(1 div 2 and 3) 0 2)
(position 'div '(1 div 2 and 3))

(defun evalution-order(cmd)
  (cond
    ((member 'add cmd) (execution-tree 'add cmd))
    ((member 'sub cmd) (execution-tree 'sub cmd))
    ((member 'div cmd) (execution-tree 'div cmd))
    (t (car cmd))
    )
  )


(defun execution-tree (op cmd)
  (let ((pos (position op cmd)))
    (cons op (list (car (subseq cmd 0 pos)) (evalution-order (nthcdr (+ 1 pos) cmd)))
          )
    )
  )


(and-struc '(1 and 2 and 3 and 4))
(and-struc '(1 and 2))


(read-input)

(defun eval-input (cmd)
  (print cmd)
  (eval cmd)
  )


(defun mul (x y)
  (* x y))

(defun add (x y)
  (+ x y))

(defun div (x y)
  (/ x y))

(defun sub (x y)
  (- x y))

(defun rsub (x y)
  (sub y x)
  )


