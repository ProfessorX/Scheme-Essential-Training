;; Sequencing
; Racket programmers prefer to write programs with as few side-effects as possible, since
; purely functional code is more easily tested and composed into larger programs. Interaction
; with the external environment, however, requires sequencing, such as when writing to a
; display, opening a graphical window, or manipulating a file on disk.


; Effects before: begin
(begin expr ...+) 
; The expr s are evaluated in order, and the result of all but the last expr is ignored. The result
; from the last expr is the result of the begin form, and it is in tail position with respect to
; the begin form.

(define (print-triangle height)
  (if (zero? height)
      (void)
      (begin
        (display (make-string height #\*))
        (newline)
        (print-triangle (sub1 height)))))
; test
(print-triangle 4)

; Many forms, such as lambda or cond support a sequence of expressions even without a
; begin. Such positions are sometimes said to have an implicit begin.

(define (print-triangle height)
  (cond
   [(positive? height)
    (display (make-string height #\*))
    (newline)
    (print-triangle (sub1 height))]))
; test
(print-triangle 4)

#|
The begin form is special at the top level, at module level, or as a body after only internal
definitions. In those positions, instead of forming an expression, the content of begin is
spliced into the surrounding context.
|#
(let ([curly 0])
  (begin
    (define moe (+1 curly))
    (define larry (+1 moe)))
  (list larry curly moe))


; Effects After: begin0
; (begin0 expr ...+)
#|
The difference is that begin0 returns the result of the first expr, instead of the result of
the last expr. The begin0 form is useful for implementing side-effects that happen after a
computation, especially in the case where the computation produces an unknown number of
results.
|#

(define (log-times thunk)
  (printf "Start: ~s\n" (current-inexact-milliseconds))
  (begin0
      (thunk)
    (printf "End...: ~s\n" (current-inexact-milliseconds))))
; test
(log-times (lambda () (sleep 0.1) 0))
(log-times (lambda () (values 1 2)))

; Effects If...: when and unless
; (when test-expr then-body ...+)
; If test-expr produces a true value, then all of the then-body s are evaluated. The result of
; the last then-body is the result of the when form. Otherwise, no then-body s are evaluated
; and the result is #<void>.

; (unless test-expr then-body ...+)
; the then-body s are evaluated only if the test-expr result is #f.

(define (enumerate lst)
  (if (null? (cdr lst))
      (printf "~a.\n" (car lst))
      (begin
        (printf "~a, " (car lst))
        (when (null? (cddr lst))
          (printf "and "))
        (enumerate (cdr lst)))))
; test
(enumerate '("Larry" "Curly" "Moe"))
(enumerate '("Life is a bitch, fuck it or leave it"))

(define (print-triangle height)
  (unless (zero? height)
    (display (make-string height #\$))
    (newline)
    (print-triangle (sub1 height))))
; test
(print-triangle 998)  ; do NOT try this at home
(print-triangle 7)


