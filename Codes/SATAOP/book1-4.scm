;;; Constructing Lists


(cons 1 '())

(define ls1
  (cons 1 '()))
ls1

(cons 2 ls1)
ls1

(define ls2 (cons 2 ls1))
ls2
ls1

(define c 'three)
(cons c ls2)
