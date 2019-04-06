
(RESTART 1)

(define (abs x)
  (cond ((< x 0) (- x ))
        (else x)))

(abs -10)
(abs 10)

(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))

(new-if (= 2 3) 0 5)
(new-if (= 0 0) 0 5)

(define (square-iter guess x )
  (if (good-enough? guess x )
      guess
      (square-iter (improve guess x) x)))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
  (square-iter 1.0 x))

(sqrt 9)
(sqrt (+ 100 37))
