;;; Racket Essentials

;; Simple values
; numbers
1 
3.14
1/2
1+2i
6.02e+23
999999999999999999999

; booleans
#t
#f

; strings
"Hello, World!"
"Benjamin \"Bugsy\" Siegel"
"λx: (ua.a->a).xx"

1.000
"Bugs \u0022Figaro\u0022 Bunny"

;; Simple definitions
; a definition of the form --> ( define <id> <expr> ) 
; ( define ( <id> <id>* ) expr+ )
(define pie 3)  ; defines pie to be 3
(define (piece str)
  (substring str 0 pie))

; test
pie
(piece "key lime")
piece
substring

(define (bake flavor)
  (printf "pre-heating oven...\n")
  (string-append flavor " pie"))

; test
(bake apple)  ; not working
(bake "apple")

(define (nobake flavor)
  string-append flavor "jello")
; test
(nobake "green")

;; identifiers
; ( ) [ ] { } " " , ' ` '; # | \

; examples
+
Hfuhruhurr
integer?
pass/fail
john-jacob-jingleheimer-schemidt
a-b-c+1-2-3

;; function calls
; ( <id> <expr>* )

(string-append "repo" "twine" "yarn")  ; append strings
(substring "corudyoiasd" 0 4)  ; extract a substring
(string-length "shoelace") ; get a string's length
(string? "Life is fucking awesome in the United Arab Emirates!")
(string? 1)
(sqrt 16)
(sqrt -16)

(+ 1 2)
(- 2 1)
(< 2 1)
(>= 2 1)

(number? "Life is fucking awesome in the UAE!")
(number? 1)

(equal? 6 "half a dozen")
(equal? 6 6)
(equal? "half dozen" "half dozen")

;; Conditionals
; ( if <expr> <expr> <expr> )

(if (> 2 3)
    "bigger"
    "smaller")

(define (reply s)
  (if (equal? "hello" (substring s 0 5))
      "hi!"
      "huh!"))

; test
(reply "lambdax:(ua.a->a).xx")

(define (reply s)
  (if (string? s)
      (if (equal? "hello" (substring s 0 5))
          "hi!"
          "huh?")
      "huh?"))
; test
; (reply "mother fucxker")

(define (reply s)
  (if (if (string? s)
          (equal? "hello" (substring s 0 5))
          #f)
      "hi!"
      "hub?"))


;; more readable conditionals
; ( and <expr>* )
; ( or <expr>* )

(define (reply s)
  (if (and (string? s)
           (>= (string-length s) 5)
           (equal? "hello" (substring s 0 5)))
      "hi!"
      "huh?"))
; test (This should be integrated into unit test, but I am not clear of the exact steps.
(define (reply-more s)
  (if (equal? "hello" (substring s 0 5))
      "hi!"
      (if (equal? "goodbye?" (substring s 0 7))
          "bye!"
          (if (equal? "?" (substring s (- (string-length s) 1)))
              "I don't know"
              "huh?"))))
 
;; shorthand for a sequence of tests
; ( cond {[ <expr> <expr>* ]} * )
(define (reply-more s)
  (cond
   [(equal? "hello" (substring s 0 5))
    "Hi!"]
   [(equal? "goodbye" (substring s 0 7))
    "Bye!"]
   [(equal? "?" (substring s (- (string-length s) 1)))
    "I don't know"]
   [else "huh?"]))
; test
; (reply-more "mine is lime green")
; (reply-more "what is your favorite color?")
; (reply-more "goodbye cruel world!") 	(reply-more "hello, racket!")


;; function calls, again
; ( <expr> <expr>* )
(define (double v)
  ((if (string? v) string-append +) v v))
; test
(double "mnah")
(double 5)

;; Anonymous functions with lambda λ
(define a 1)
(define b 2)
(+ a b) ;; isn't that tedious?

(define (twice f v)
  (f (f v)))  ;; later on we will realize there is a thing called "Contract"
; test
(twice sqrt 16)

(define (louder s)
  (string-append s "!"))
; test
(twice louder "Hello")  ;; but if the call to twice is the only place where louder is used...

; ( lambda ( <id>* ) <expr>+ )
(λ (s) (string-append s "!"))

(twice (λ (s) (string-append s "!"))
       "hello")
(twice (λ (s) (string-append s "?!"))
       "hello")

; Another use of lambda is as a result for a function that generates functions
(define (make-add-suffix s2)
  (λ (s) (string-append s s2)))
; test
(twice (make-add-suffix "!") "hello")
(twice (make-add-suffix "?!") "hello")
(twice (make-add-suffix "...") "hello")

; Racket is a lexically scoped language, which means that s2 in the function returned by
; make-add-suffix always refers to the argument for the call that created the function.
(define louder (make-add-suffix "!"))
(define less-sure (make-add-suffix "?"))
; test
(twice less-sure "really")
(twice louder "really")

; The following two are equivalent
(define (louder s)
  (string-append s "!"))
(define louder
  (λ (s)
     (string-append s "!")))

;; local bindings with define, let and let*
; (define ( <id> <id>* ) <definition>* <expr>+ )
; (λ ( <id>* ) <definition>* <expr>+)
; Definitions at the start of a function body are local to the function body.
(define (converse s)
  (define (starts? s2)  ; local to converse
    (define len2 (string-length s2))
    (and (>= (string-length s) len2)
         (equal? s2 (substring s 0 len2))))
  (cond
   [(starts? "hello") "hi!"]
   [(starts? "goodbye") "bye!"]
   [else "huh?"]))
;test
(converse "hello!")
(converse "urp")
starts?

;; another way to create local bindings
; ( let ( { [ <id> <expr> ]}*) <expr>+ )
(let ([x (random 4)]
      [o (random 4)])
  (cond
   [(> x o) "X wins"]
   [(> o x) "O wins"]
   [else "cat's game"]))

; The let* form, in contrast, allows later clauses to use earlier
; bindings
(let* ([x (random 4)]
       [o (random 4)]
       [diff (number->string (abs (- x o)))])
  (cond
   [(> x 0) (string-append "X wins by " diff)]
   [(> o x) (string-append "O wins by " diff)]
   [else "cat's game"]))
