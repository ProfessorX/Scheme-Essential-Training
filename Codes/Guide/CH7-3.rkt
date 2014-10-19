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


; Keyword Arguments
; Please refer to yes-or-no-gui.rkt

;; Optional Keywords Arguments
(define (ask-yes-or-no-question question
                                #:default answer
                                #:title [title "Yes or No?"]
                                #:width [w 400]
                                #:height [h 200])
  ...)

(provide (contract-out
          [ask-yes-or-no-question
           (->* (string?
                 #:default boolean?)
                (
                 #:title string?
                         #:width exact-integer?
                         #:height exact-integer?)
                boolean?)]))


; Contracts for case-lambda
(define report-cost
  (case-lambda
    [(lo hi) (format "between $~a and $~a" lo hi)]
    [(desc) (format "~a of dollars" desc)]))

(provide (contract-out
          [report-cost
           (case->
            (integer? integer? . -> . string?)
            (string? . -> . string?))]))


; Argument and Result Dependencies

; The following is an excerpt from an imaginary numerics module:
(provide
 (contract-out
  [real-sqrt (->i ([argument (>=/c 1)])
                 ([result (argument) (<=/c argument)]))]))

#|
The contract for the exported function real-sqrt uses the ->i rather than ->* function
contract. The “i” stands for an indy dependent contract, meaning the contract for the function
range depends on the value of the argument. The appearance of argument in the line for
result’s contract means that the result depends on the argument. In this particular case, the
argument of real-sqrt is greater or equal to 1, so a very basic correctness check is that the
result is smaller than the argument.
|#


(provide (contract-out
          [balance (-> account? amount/c)]
          [withdraw (-> account? amount/c account?)]
          [deposit (-> account? amount/c account?)]))


; The following implementation enforces
; those constraints and guarantees through contracts:


; Checking State Changes
(->i ([parent (is-a?/c area-container-window<%>)])
     [_ (parent)
        (let ([old-children (send parent get-children)])
          (lambda (child)
            (andmap eq?
                    (append old-children (list child))
                    (send parent get-children))))])

#|
The range contract ensures that the function only modifies the children of parent by adding
a new child to the front of the list. It accomplishes this by using the _ instead of a normal
identifier, which tells the contract library that the range contract does not depend on the
values of any of the results, and thus the contract library evaluates the expression follow-
ing the _ when the function is called, instead of when it returns. Therefore the call to the
get-children method happens before the function under the contract is called. When the
function under contract returns, its result is passed in as child, and the contract ensures that
the children after the function return are the same as the children before the function called,
but with one more child, at the front of the list.
|#


#lang racket
(define x '())
(define (get-x) x)
(define (f) (set! x (cons 'f x)))
(provide
 (contract-out
  [f (->i () [_ (begin (set! x (cons 'ctc x)) any/c)])]
  [get-x (-> (listof symbol?))]))



; Multiple Result Values
; The function split consumes a list of chars and delivers the string that occurs before the
; first occurrence of #\newline (if any) and the rest of the list
(define (split l)
  (define (split l w)
    (cond
     [(null? l) (values (list->string (reverse w)) '())]
     [(char=? #\newline (car l))
      (values (list-string (reverse w)) (cdr l))]
     [else (split (cdr l) (cons (car l) w))]))
  (split-at l '()))

; It is a typical multiple-value function, returning two values by traversing a single list.


(provide (contract-out
          [split-at (-> (listof char?)
                        (values string? (listof char?)))]))

(provide (contract-out
          [split (->* ((listof char?))
                      ()
                      (values string? (listof char?)))]))


(define (substring-of? s)
  (flat-named-contract
   (format "substring of ~s" s)
   (lambda (s2)
     (and (string? s2)
          (<= (string-length s2) (string-length s))
          (equal? (substring s 0 (string-length s2)) s2)))))

(provide
 (contract-out
  [split (->i ([fl (listof char?)])
              (values [s (fl) (substring-of? (list->string fl))]
                      [c (listof char?)]))]))
#|
Like ->*, the ->i combinator uses a function over the argument to create the range contracts.
Yes, it doesn’t just return one contract but as many as the function produces values: one
contract per value. In this case, the second contract is the same as before, ensuring that the
second result is a list of chars. In contrast, the first contract strengthens the old one so that
the result is a prefix of the given word.
|#

; Here is a slightly cheaper version:
(provide
 (contract-out
  [split-at (->i ([fl (listof char?)])
                 (values [s (fl) (string-len/c (length fl))]
                         [c (listof char?)]))]))



; Fixed but Statistically Unknown Arities


#|
The argument of n-step is proc, a function proc whose results are either numbers or false,
and a list. It then applies proc to the list inits. As long as proc returns a number, n-step
treats that number as an increment for each of the numbers in inits and recurs. When proc
returns false, the loop stops.
|#

; (number ... -> (union #f number?)) (listof number) -> void
(define (n-step proc inits)
  (let ([inc (apply proc inits)])
    (when inc
      (n-step proc (map (lambda (x) (+ x inc)) inits)))))

; nat -> nat
(define (f x)
  (printf "~s\n" x)
  (if (= x 0) #f -1))
; test
(n-step f '(2))

; nat nat -> nat
(define (g x y)
  (define z (+ x y))
  (printf "~s\n" (list x y z))
  (if (= z 0) #f -1))  ; what if the last is "+1"
; test
(n-step g '(1 1))

#|
The correct contract uses the unconstrained-domain-> combinator, which specifies only
the range of a function, not its domain. It is then possible to combine this contract with an
arity test to specify the correct contract for n-step:
|#

(provide
 (contract-out
  [n-step
   (->i ([proc (inits)
               (and/c (unconstrained-domain->
                       (or/c false/c number?))
                      (lambda (f) (procedure-arity-includes?
                                   f
                                   (length inits))))]
         [inits (listof number?)])
        ()
        any)]))
