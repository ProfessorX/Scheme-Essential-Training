;; Contracts: A Through Example
#|
This section develops several different flavors of contracts for one and the same example:
Racket’s argmax function. According to its Racket documentation, the function consumes
a procedure proc and a non-empty list of values, lst. It

returns the first element in the list lst that maximizes the result of proc.

|#

; Examples
(argmax add1 '(1 2 3))
(argmax sqrt (list 0.4 0.9 0.16))
(argmax second '((a 2) (b 3) (c 4) (d 1) (e 4)))


; Here is the simplest possible contract for this function:
#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax (-> (-> any/c real?) (and/c pair? list?) any/c)]))

#|
This contract captures two essential conditions of the informal description of argmax:
• the given function must produce numbers that are comparable according to <. In
particular, the contract (-> any/c number?) would not do, because number? also
recognizes complex numbers in Racket.
• the given list must contain at least one item.
|#

#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (define f@r (f r))
             (for/and ([v lov]) (>= f@r (f v))))))]))



; version 2 rev. a
#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (define f@r (f r))
             (and (memq r lov)
                  (for/and ([v lov]) (>= f@r (f v)))))))]))
#|
The memq function ensures that r is intensionally equal to one of the members of lov. Of
course, a moment’s worth of reflection shows that it is impossible to make up such a value.
Functions are opaque values in Racket and without applying a function, it is impossible
to determine whether some random input value produces an output value or triggers some
exception. So we ignore this possibility from here on.
|#


#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (define f@r (f r))
             (and (for/and ([v lov]) (>=  f@r (f v)))
                  (eq? (first (memf (lambda (v) (= (f v) f@r)) lov))
                       r)))))]))
#|
That is, the memf function determines the first element of lov whose value under f is equal
to r’s value under f. If this element is intensionally equal to r, the result of argmax is
correct.
|#

; version 3 rev. a

#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (define f@r (f r))
             (and (is-first-max? r f@r f lov)
                  (dominates-all f@r f lov)))))]))

; where
; f@r is greater or equal to all (f v) for v in lov
(define (dominates-all f@r f lov)
  (for/and ([v lov]) (>= f@r (f v))))

; r is eq? to the first element v of lov for which (pred? v)
(define (is-first-max? r f@r f lov)
  (eq? (first (memf (lambda (v) (= (f v) f@r)) lov)) r))


; version 3 rev. b
#lang racket

(define (argmax f lov) ...)

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (define f@r (f r))
             (define flov (map f lov))
             (and (is-first-max? r f@r (map list lov flov))
                  (dominates-all f@r f flov)))))]))

; where

; f@r is greater or equal to all f@v in flov
(define (dominates-all f@r flov)
  (for/and ([f@v flov]) (>= f@r f@v)))

; r is (first x) for the first x in lov+flov s.t. (= (second x) f@r)
(define (is-first-max? r f@r lov+flov)
  (define fst (first lov+flov))
  (if (= (second fst) f@r)
      (eq? (first fst) r)
      (is-first-max? r f@r (rest lov+flov))))


; version 4
#lang racket

(define (argmax f lov)
  (if (empty? (rest lov))
      (first lov)
      ...))

(provide
 (contract-out
  [argmax
   (->i ([f (-> any/c real?)] [lov (and/c pair? list?)]) ()
        (r (f lov)
           (lambda (r)
             (cond
              [(empty? (rest lov)) (eq? (first lov) r)]
              [else
               (define f@r (f r))
               (define flov (map f lov))
               (and (is-first-max? r f@r (map list lov flov))
                    (dominates-all f@r f flov))]))))]))


#|
The problem of diverging or exception-raising functions should alert the reader to the even
more general problem of functions with side-effects. If the given function f has visible
effects – say it logs its calls to a file – then the clients of argmax will be able to observe
two sets of logs for each call to argmax. To be precise, if the list of values contains more
than one element, the log will contain two calls of f per value on lov. If f is expensive to
compute, doubling the calls imposes a high cost.
|#
