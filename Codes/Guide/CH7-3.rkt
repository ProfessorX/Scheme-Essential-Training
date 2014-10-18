;; Contracts on Functions in General
; 20141019 Lab 02:00
#|
The -> contract constructor works for functions that take a fixed number of arguments and
where the result contract is independent of the input arguments. To support other kinds of
functions, Racket supplies additional contract constructors, notably ->* and ->i.
|#

; Optional Arguments

#lang racket

(provide
 (contract-out
  ; pad the given str left and right with
  ; the (optional) char so that it is centered
  [string-pad-center (->* (string? natural-number/c)
                          (char?)
                          string?)]))

(define (string-pad-center str width [pad #\space])
  (define field-width (min width (string-length str)))
  (define rmargin (ceiling (/ (- width field-width) 2)))
  (define lmargin (floor (/ (- width field-width) 2)))
  (string-append (build-string lmargin (lambda (x) pad))
                 str
                 (build-string rmargin (lambda (x) pad))))


; Rest Arguments
(define (max-abs n . rst)
  (foldr (lambda (n m) (max (abs n) m)) (abs n) rst))

(provide
 (contract-out
  [max-abs (->* (real?) () #:rest (listof real?) real?)]))
