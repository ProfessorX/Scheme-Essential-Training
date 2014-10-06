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
