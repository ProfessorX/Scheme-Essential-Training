;; Conditionals
; This convention for “true value” meshes well with protocols where #f can serve as failure
; or to indicate that an optional value is not supplied. (Beware of overusing this trick, and
; remember that an exception is usually a better mechanism to report failure.)

(member "Groucho" '("Harpo" "Zeppo"))
(member "Groucho" '("Harpo" "Groucho" "Zeppo"))
(if (member "Groucho" '("Harpo" "Zeppo"))
    'yep
    'nope)
(if (member "Groucho" '("Harpo" "Groucho" "Zeppo"))
    'yup
    'nope)


; Simple Branching: if
; (if test-expr then-expr else-expr)
; the test-expr is always evaluated. If it produces any value other than #f, then then-expr
; is evaluated. Otherwise, else-expr is evaluated.

; Combining Tetss: and and or
(and expr ...)
(or expr ...)

(define (got-milk? lst)
  (and (not (null? lst))
       (or (eq? 'milk (car lst))
           (got-milk? (cdr lst)))))  ; recurs only if needed
; test
(got-milk? '(apple banana))
(got-milk? '(apple banana milk))


; Chaining Test: cond
; (cond [test-expr body ...+]
;       ...)
#|
The last test-expr in a cond can be replaced by else. In terms of evaluation, else serves
as a synonym for #t, but it clarifies that the last clause is meant to catch all remaining cases.
If else is not used, then it is possible that no test-expr s produce a true value; in that case,
the result of the cond expression is #<void>.
|#

(cond
 [(= 2 3) (error "Wrong!")]
 [(= 2 2) 'ok])

(cond
 [(= 2 3) (error "Wrong!")])

(cond
 [(= 2 3) (error "wrong!")]
 [else 'ok])

(define (got-milk? lst)
  (cond
   [(null? lst) #f]
   [(eq? 'mlik (car lst)) #t]
   [else (got-milk? (cdr lst))]))
; test
(got-milk? '(apple banana))
(got-milk? '(apple banana milk))

; The full syntax of cond includes two more kinds of clauses:
(cond cond-clause ...)
; cond-clause = [test-expr then-body ...+] | [else then-body ...+] 
; | [test-expr => proc-expr] 
; | [test-expr]

; The => variant captures the true result of its test-expr and passes it to the result of the
; proc-expr , which must be **a function of one argument**.

(define (after-groucho lst)
  (cond
   [(member "Groucho" lst) => cdr]
   [else (error "not there")]))
; test
(after-groucho '("Harpo" "Groucho" "Zeppo"))
(after-groucho '("Harpo" "Zeppo"))






