;; Definitions: define
; a basic definition has the form
; (define id expr)
; in which case id is bound to the result of expr

(define salutation (list-ref '("Hi" "Hello") (random 2)))
salutation

; Function shorthand
; (define (id arg ...) (body ...+))
; which is a shorthand for
; (define id (lambda (arg ...) body ...+))

(define (greet name)
  (string-append salutation ", " name))
;test
(greet "John")


(define (greet first [surname "Smith"] #:hi [hi salutation])
  (string-append hi ", " first " " surname))
;test
(greet "John")
(greet "John" #:hi "Hey")
(greet "John" "Doe")

; (define (id arg ... . rest-id) body ...+)
; The function shorthand via define also supports a rest argument 
; (i.e., a final argument to  collect extra arguments in a list)
(define (avg . l)
  (/ (apply + l) (length l)))
(avg 1 2 3)

; Curried Functions Shorthand
(define make-add-suffix
  (lambda (s2)
    (lambda (s) (string-append s s2))))
((make-add-suffix "!") "Hello Masdar")

#|
In a sense, make-add-suffix is a function takes two arguments, but it takes them one at a
time. A function that takes some of its arguments and returns a function to consume more is
sometimes called a curried function.
|#

; Using the function-shorthand form of define
(define (make-add-suffix s2)
  (lambda (s) (string-append s s2)))

(define louder (make-add-suffix "!"))
(define less-sure (make-add-suffix "?"))
; test
(less-sure "really")
(louder "really")

; (define (head args) body ...+)
; head = id | (head args)
; args = arg ... | arg ... . rest-id


; Multiple Values and define-values
; A Racket expression normally produces a single result, but some expressions can produce
; multiple results.
(quotient 13 3)
(remainder 13 3)
(quotient/remainder 13 3)
(values 1 2 3)

(define (split-name name)
  (let ([parts (regexp-split " " name)])
    (if (= (length parts) 2)
        (values (list-ref parts 0) (list-ref parts 1))
        (error "not a <first> <last> name"))))
(split-name "You son of a bitch!")
(split-name "Abraham Xiao")

; The define-values form binds multiple identifiers at once to multiple results produced
; from a single expression
; (define-values (id ...) expr)
(define-values (given surname) (split-name "Adam Smith"))
; test
given
surname

; Internal Definitions
; (lambda gen-formals
;   body ...+)
(lambda (f)  ; no definitions
  (printf "running\n")
  (f 0))

(lambda (f)  ; one definition
  (define (log-it what)
    (printf "~a\n" what))
  (log-it "running")
  (f 0)
  (log-it "done"))

(lambda (f n)
  (define (call n)
    (if (zero? n)
        (log-it "done")
        (begin
          (log-it "running")
          (f n)
          (call (- n 1)))))
  (define (log-it what)
    (printf "~a\n" what))
  (call n))


#|
Internal definitions in a particular body sequence are mutually recursive; that is, any defini-
tion can refer to any other definition—as long as the reference isn’t actually evaluated before
its definition takes place. If a definition is referenced too early, an error occurs.
|#
; This will NOT work
(define (weird)
  (define x x)
  x)
; test
(weird)




