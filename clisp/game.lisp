
(defparameter *nodes* '((living-room (you are in the living-room.
                                          a wizard is snoring loudly on the couch.))
                        (garden (you are in a beautiful garden.
                                     there is a well in front of you.))
                        (attic (you are in the attic.
                                    there is a giant welding torch in the corner.))))

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

(describe-location 'living-room *nodes*)

(defparameter *edges* '((living-room (garden west door)
                                     (attic upstairs ladder))
                        (garden (living-room east door))
                        (attic (living-room downstairs ladder))))

(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(caddr '(garden west door))
(cdr '(garden west door))
(mapcar #'sqrt '(1 2 3 4 5))
(mapcar #'car '((foo bar) (baz qux)))
(mapcar #'cdr '((foo bar) (baz qux)))
(append '(mary had) '(a) '(little lamb))
(apply #'append '((THERE IS A DOOR GOING WEST FROM HERE.)
                  (THERE IS A LADDER GOING UPSTAIRS FROM HERE.)))


(describe-paths 'living-room *edges*)
(describe-path '(garden west door))

(defparameter *objects* '(whiskey bucket frog chain))
(defparameter *object-locations* '((whiskey living-room)
                                   (bucket living-room)
                                   (chain garden)
                                   (frog garden)))

(defun objects-at (loc objs obj-locs)
  (labels ((at-loc-p (obj)
                     (eq (cadr (assoc obj obj-locs)) loc)))
    (remove-if-not #'at-loc-p objs)))

(objects-at 'living-room *objects* *object-locations*)

(defun describe-objects (loc objs obj-loc)
  (labels ((describe-obj (obj)
                         `(you see a ,obj on the floor.)))
    (apply #'append (mapcar #'describe-obj (objects-at loc objs obj-loc)))))


(describe-objects 'living-room *objects* *object-locations*)
(defparameter *location* 'living-room)

(defun look ()
  (append (describe-location *location* *nodes*)
          (describe-paths *location* *edges*)
          (describe-objects *location* *objects* *object-locations*)))

(defun walk (direction)
  (let ((next (find direction
                    (cdr (assoc *location* *edges*))
                    :key #'cadr)))
    (if next
      (progn (setf *location* (car next))
             (look))
      '(you cannot go that way.))))

(find 'z '((5 x) (3 y) (7 z)) :key #'cadr)


(defun pickup (object)
  (cond ((member object
                 (objects-at *location* *objects* *object-locations*))
         (push (list object 'body) *object-locations*)
         `(you are now carrying the ,object))
        (t '(you cannot get that.))))


(defun inventory ()
  (cons 'items- (objects-at 'body *objects* *object-locations*)))


;(progn (print "this")
       ;(print "is")
       ;(print "a")
       ;(print "test"))

;(progn (prin1 "this")
       ;(prin1 "is")
       ;(prin1 "a")
       ;(prin1 "test"))

;(defun say-hello ()
  ;(print "Please type your name:")
  ;(let ((name (read)))
    ;(princ "Nice to meet you, ")
    ;(princ name)))

;(progn (princ "This sentence will be interrupted")
       ;(princ #\newline)
       ;(princ "by an annoying newline character."))



(defun game-repl ()
  (let ((cmd (game-read)))
    (unless (eq (car cmd) 'quit)
      (game-print (game-eval cmd))
      (game-repl))))


(defun game-read ()
  (let ((cmd (read-from-string
               (concatenate 'string "(" (read-line) ")"))))
    (flet ((quote-it (x)
                     (list 'quote x)))
      (cons (car cmd) (mapcar #'quote-it (cdr cmd))))))

(defparameter *allowed-commands* '(look walk pickup inventory))

(defun game-eval (sexp)
  (if (member (car sexp) *allowed-commands*)
    (eval sexp)
    '(i do not know that command.)))

(defun tweak-text (lst caps lit)
  (when lst
    (let ((item (car lst))
          (rest (cdr lst)))
      (cond ((eq item #\space) (cons item (tweak-text rest caps lit)))
            ((member item '(#\! #\? #\.)) (cons item (tweak-text rest t lit)))
            ((eq item #\") (tweak-text rest caps (not lit)))
            (lit (cons item (tweak-text rest nil lit)))
            ((or caps lit) (cons (char-upcase item) (tweak-text rest nil lit)))
            (t (cons (char-downcase item) (tweak-text rest nil nil)))))))

(defun game-print (lst)
  (princ (coerce (tweak-text (coerce (string-trim "() "
                                                  (prin1-to-string lst))
                                     'list)
                             t
                             nil)
                 'string))
  (fresh-line))

;(game-print '(THIS IS A SENTENCE. WHAT ABOUT THIS? PROBABLY.))
;(game-print '(not only does this sentence have a "comma," it also mentions
;the "iPad."))


;(print "Hello! there ")
;(game-repl)

(defparameter *wizard-nodes* '((living-room (you are in the living-room.
                                                 a wizard is snoring loudly on the couch.))
                               (garden (you are in a beautiful garden.
                                            there is a well in front of you.))
                               (attic (you are in the attic. there
                                           is a giant welding torch in the corner.))))
(defparameter *wizard-edges* '((living-room (garden west door)
                                            (attic upstairs ladder))
                               (garden (living-room east door))
                               (attic (living-room downstairs ladder))))

(ugraph->png "uwizard.dot" *wizard-nodes* *wizard-edges*)
