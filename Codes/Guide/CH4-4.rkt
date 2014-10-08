;; Functions (Procedures): lambda
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

; TODO: Finish the 100 page or more programming as soon as possible.
(define (trace-wrap f)
  (make-keyword-procedure
   (lambda (kws kw-args . rest)
     (printf "Called with ~s ~s ~s\n" kws kw-args rest)
     (keyword-apply f kws kw-args rest))))

((trace-wrap greet) "John" #:hi "Howdy")

;; Arity-Sensitive Functions: case-lambda
; (case-lambda 
;   [formals body ..+]
;   ...)
; formals = (arg-id ...) | rest-id | (arg-id ...+ . rest-id)
; The case-lambda form creates a function that can have completely different behaviors
; depending on the number of arguments that are supplied.
(define greet
  (case-lambda
    [(name) (string-append "Hello, " name)]
    [(given surname) (string-append "Hello, " given " " surname)]))
; test
(greet)
(greet "John")
(greet "John" "Smith")




