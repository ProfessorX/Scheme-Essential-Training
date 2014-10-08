;; Function Calls


; (proc-expr arg-expr ...)
; is a function call—also known as a procedure application—when proc-expr is not an
; identifier that is bound as a syntax transformer (such as if or define).

; evaluation order and arity
(cons 1 null)
(+ 1 2 3)
(cons 1 2 3)
(cons 1 '(2 . 3))
(1 2 3)

; keyword arguments
; (proc-expr arg ...)
; arg = arg-expr | arg-keyword arg_expr
(go "super.rkt" #:mode 'fast)
(go "super.rkt" #:mode #:fast)  ; syntax error
; The #:mode keyword must be followed by an expression to produce an
; argument value, and #:fast is not an expression.
(go #:mode 'fast "super.rkt")  ; equivalent

(define (avg lst)  ; will NOT work
  (/ (+ lst) (length llst)))
(avg '(1 2 3))

(define (avg lst)  ; YOU GUESSED IT!
  (/ (+ (list-ref lst 0) (list-ref lst 1) (list-ref lst 2))
     (length lst)))
(avg '(1 2 3))
(avg '(1 2 3 4))
(avg '(1 2 3 4 5))  ; Holy Crap!

; The "apply" function
; It takes a function and a list argument, and it applies the function to the values in the list
(define (avg lst)
  (/ (apply + lst) (length lst)))
(avg '(1 2 3))
(avg '(1 2 3 4))
(avg '(1 2 3 4 5))  ; Holy Crap!

(define (anti-sum lst)
  (apply - 0 lst))
(anti-sum '(1 2 3))
(anti-sum '(1 2 3 4 5 888 -998))

(apply go #:mode 'fast '("super.rkt"))  ; for this time, go is still not defined
(apply gp '("super.rkt") #:mode 'fast)

; To pass a list of keyword arguments to a function, use the keyword-apply function
(keyword-apply go
               '(#:mode)
               '(fast)
               '("super.rkt"))


