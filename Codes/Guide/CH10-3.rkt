;; Continuations
#|
A continuation is a value that encapsulates a piece of an expression’s evaluation context.
The call-with-composable-continuation function captures the current continuation
starting outside the current function call and running up to the nearest enclosing prompt.
(Keep in mind that each REPL interaction is implicitly wrapped in a prompt.)
|#

(+ 1 (+ 1 (+ 1 0)))

(define saved-k #f)

(define (save-it!)
  (call-with-composable-continuation
   (lambda (k)  ; k is the captured continuation
     (set! saved-k k)
     0)))

(+1 (+1 (+1 (save-it!))))
; test
(saved-k 0)
(saved-k 10)
(saved-k (saved-k 0))
(define (sum n)
  (if (zero? n)
      (save-it!)
      (+ n (sum (sub1 n)))))
