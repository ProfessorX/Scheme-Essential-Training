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


; Functions (Procedures): lambda
; A lambda expression creates a function.
(lambda (arg-id ...)
  body ...+)
((λ (x) x)
 1)
((λ (x y) (+ x y))
 1 2)
((λ (x y) (+ x y))
 1)  ; Oops!

; declaring a rest argument
(lambda rest-id
  body ...+)  ; Apparently, this function will NOT work
#|
That is, a lambda expression can have a single rest-id that is not surrounded by parenthe-
ses. The resulting function accepts any number of arguments, and the arguments are put into
a list bound to rest-id .
|#
((λ x x)
 1 2 3)
((λ x x))
((λ x (car x))
 1 2 3)

(define max-mag
  (λ nums
     (apply max (map magnitude nums))))
(max 1 -2 0)
(max-mag 1 -2 0)

(lambda (arg-id ...+ . rest-id)
  body ...+)

; this one will NOT work
(define max-mag
  (λ (num . nums)
     (apply max-mag (map magnitude (cons num nums)))))  ; BITCH!!! SOMETHING IS WRONG.

; this one will work
(define max-mag
  (λ (num . nums)
     (apply max (map magnitude (cons num nums)))))
; test
(max-mag 1 -2 0)
(max-mag)
(max-mag 1 998 -1000 2012 )

; declaring optional arguments
; (lambda gen-formals
;   body ...+)
; gen-formals = (argmax ...) | rest-id | (argmax ...+ . rest-id)
; arg = arg-id | [arg-id default-expr] |

(define greet
  (λ (given [surname "Smith"])
     (string-append "Hello, " given " " surname)))
; test
(greet "John" "Doe")

(define greet 
  (lambda (given [surname (if (equal? given "John")
                              "Doe"
                              "Smith")])
    (string-append "Hello, " given " " surname)))
; test
(greet "Bitch")
(greet "Adam")

; declaring keyword arguments
; (lambda gen-formals
;   body ...+)
; gen-formals = (arg ...) | rest-id | (arg ...+ . rest-id)
; arg = arg-id | [arg-id default-expr] | arg-keyword arg-id | arg-keyword [arg-id default-expr]

(define greet
  (lambda (given #:last surname)
    (string-append "Hello, " given " " surname)))

(greet "John" #:last "Smith")
(greet #:last "Doe" "John")

; An arg-keyword [arg-idment default-expr ] argument specifies a keyword-based argument 
; with a default  value.

(define greet
  (lambda (#:hi [hi "Hello"] given #:last [surname "Smith"])
    (string-append hi ", " given " " surname)))

(greet "John")
(greet "Karl" #:last "Marx")
(greet "John" #:hi "Howdy")
(greet "Karl" #:last "Marx" #:hi "Guten Tag")





