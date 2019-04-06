(defparameter *small* 1)
(defparameter *big* 100)

(defun guess_my_number()
  (ash (+ *small* *big*) -1)
  )

(defun smaller()
  (setf *big* (1- (guess_my_number )))
  (guess_my_number))

(defun bigger()
  (setf *big* (1+ (guess_my_number )))
  (guess_my_number))


(defun start_over()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess_my_number))

(princ "Tutti frutti")

;declaring local variables with "let"
(let ((a 5)
      (b 6))
  (+ a b))

;declaring local functions with "flet"
(flet ((f (n)
          (+ n 10))
       (g (n)
          (- n 3)))
  (g (f 5)))

; symbols
(eq 'fooo 'FoOo)
(expt 53 53)
'(expt 2 3)

;Placing a quote in front of lists so that they won’t be evaluated as a command is called quoting.
;By using quoting, you can tell Lisp, “This next part
;isn’t a command. It’s just a chunk of data for my program.”


(cons 'chicken 'cat)
(cons 'pork '(beef chicken))
(car '(pork beef chicken))
(cdr '(pork beef chicken))
(list 'pork 'beef 'chicken)
'(cat (duck bat) ant)

(if '()
  'i-am-true
  'i-am-false)

(if '(1)
  'i-am-true
  'i-am-false)

(defun my-length (list)
  (if list
    (1+ (my-length (cdr list)))
    0))

(my-length '(list with four symbols))

(eq '() nil)
(eq '() ())
(eq '() 'nil)

(defvar *arch-enemy* nil)

(defun pudding-eater (person)
  (cond ((eq person 'henry) (setf *arch-enemy* 'stupid-lisp-alien)
                            '(curse you lisp alien – you ate my pudding))
        ((eq person 'johnny) (setf *arch-enemy* 'useless-old-johnny)
                             '(i hope you choked on my pudding johnny))
        (t '(why you eat my pudding stranger ?))))

(pudding-eater 'johnny)


(defun pudding-eater (person)
  (case person
    ((henry) (setf *arch-enemy* 'stupid-lisp-alien)
             '(curse you lisp alien – you ate my pudding))
    ((johnny) (setf *arch-enemy* 'useless-old-johnny)
              '(i hope you choked on my pudding johnny))
    (otherwise '(why you eat my pudding stranger ?))))

(pudding-eater 'john)

(if (member 1 '(3 4 1 5))
  'one-is-in-the-list
  'one-is-not-in-the-list)

(member 4 '(3 4 1 5))

(find-if #'oddp '(2 4 5 6))

(eq 'arbaaz 'arbaaz)
(eql 'foo 'foo)
(equal 5 5)
(equal "foo" "foo")
(equalp "Bob Smith" "bob smith")
(equalp 0 0.0)

