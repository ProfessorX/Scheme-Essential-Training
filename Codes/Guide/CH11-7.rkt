;; for/fold and for*/fold
#|
The for/fold form is a very general way to combine iteration results. Its syntax is slightly
different than the syntax of for, because accumulation variables must be declared at the
beginning:


(for/fold ([accum-id init-expr] ...)
    (clause ...)
  body ...+)
|#
(for/fold 
    ([len 0])
    ([chapter '("Intro" "Conclusion")])
  (+ len (string-length chapter)))

(for/fold 
    ([prev #f])
    ([i (in-naturals 1)]
     [chapter '("Intro" "Details" "Details" "Conclusion")]
     #:when (not (equal? chapter prev)))
  (printf "~a . ~a\n" i chapter)
  chapter)


#|
When multiple accum-id s are specified, then the last body must produce multiple values,
one for each accum-id . The for/fold expression itself produces multiple values for the
results.
|#
(for/fold
    ([prev #f]
     [counter 1])
    ([chapter '("Intro" "Details" "Details" "Conclusion")]
     #:when (not (equal? chapter prev)))
  (printf "~a. ~a\n" counter chapter)
  (values chapter
          (add1 counter)))
