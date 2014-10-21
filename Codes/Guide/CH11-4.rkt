;; for/vector and for*/vector
(for/vector ([i (in-naturals 1)]
           [chapter '("Intro" "Details" "Conclusion")])
  (string-append (number->string i) ". " chapter))

(let ([chapters '("Intro" "Details" "Conclusion")])
  (for/vector #:length (length chapters) ([i (in-naturals 1)]
                                          [chapter chapters])
              (string-append (number->string i) ". " chapter)))


#|
If a length is provided, the iteration stops when the vector is filled or the requested iterations
are complete, whichever comes first. If the provided length exceeds the requested number
of iterations, then the remaining slots in the vector are initialized to the default argument of
make-vector.
|#

