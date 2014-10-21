;;; Exceptions and Control
#|
Racket provides an especially rich set of control operations—not only operations for rais-
ing and catching exceptions, but also operations for grabbing and restoring portions of a
computation.
|#

;; Exceptions
(/ 1 0)
(car 998)

; To catch an exception, use the with-handlers form
(with-handlers ([predicate-expr handler-expr] ...)
  body ...+)

#|
Each predicate-expr in a handler determines a kind of exception that is caught by the
with-handlers form, and the value representing the exception is passed to the handler
procedure produced by handler-expr . The result of the handler-expr is the result of
the with-handlers expression.
|#

(with-handlers ([exn:fail:contract:divide-by-zero? 
                 (lambda (exn) +inf.0)])
  (/ 1 0))
(with-handlers ([exn:fail:contract:divide-by-zero?
                 (lambda (exn) +inf.0)])
  (car 17))


(error "Life is fucking awesome in the United Arab Emirates!")
(with-handlers ([exn:fail? (lambda (exn) 'air-bag)])
  (error "crash!"))

(raise 2)
(with-handlers ([(lambda (v) (equal? v 2)) (lambda (v) 'two)])
  (raise 2))

(with-handlers ([(lambda (v) (equal? v 2)) (lambda (v) 'two)])
  (/ 1 0))


#|
Multiple predicate-expr s in a with-handlers form let you handle different kinds of
exceptions in different ways. The predicates are tried in order, and if none of them match,
then the exception is propagated to enclosing contexts.
|#

(define (always-fail n)
  (with-handlers ([even? (lambda (v) 'even)]
                  [positive? (lambda (v) 'positive)])
    (raise n)))

(always-fail 2)
(always-fail 3)
(always-fail -3)

(with-handlers ([negative? (lambda (v) 'negative)])
  (always-fail -3))


(with-handlers ([exn:fail? (lambda (v) 'oops)])
  (car 17))

(with-handlers ([exn:fail? (lambda (V) 'ooop)])
  (break-thread (current-thread)) ; simulate Ctrl-C
  (car 17))
