; 1.2
(RESTART 1)

(/ (+ (+ 5 4) (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))

; 1.3
(define (sum-square a b )
  (+ (* a a ) (* b b)))


(define (max a b)
  (if (>= a b) a b)
)

(define (max-two a b c)
  (if (>= a b)
      (if (>= b c)
          (list a b)
          (list a c))
      (if (>= a c)
          (list b a)
          (list b c))))

(define (max-sum-square a b c)
  (apply sum-square (max-two a b c)))


(max-sum-square 1 2 3)

; 1.4
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b)
)

(a-plus-abs-b 1 -2)
(a-plus-abs-b 1 2)

; 1.5
;(define (p) (display "im"))
(define (p) (p))

(define (test x y)
  (if (= x 0) 0  y)
)

(test 0 (p))
(test 0 1)


; multiple args
( define (sum . args) (apply + args))
(sum 1 2 3 )
(apply sum (list 1 2 3 4 5))


