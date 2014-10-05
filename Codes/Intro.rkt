(+ 1 1)
(+ 2 2)
(* 3 3)
(- 4 2)
(/ 6 2)

(sqr 3)
(expt 2 3)
(sin 0)
(sin pi)
(cos pi)

; Basic computation
(+ 2 (+ 3 4))
(+ 2 3 4)

(+ 2 (+ (* 3 3) 4))
(+ 2 (+ (* 3 (/ 12 4)) 4))

(+ (* 5 5) (+ (* 3 (/ 12 4)) 4))


; Somet
(+ (1 (2)))
(+ (1) (2))

(a b c (d e))

(+ 1 2 3 4 5 6 7 8 9 0)
(* 1 2 3 4 5 6 7 8 9 0)

; Arithmetic and Arithmetic
(string-append "hello" "world")\
(string-append "hello " "world")
(string-append "hell" "o" "world")
(string-append "hello" " " "world")

(+ (string-length "hello world") 20)

(number->string 42)
(string->number 42) ; This will not work!
(string->number "42") ; This will work

(string->number "hello world")

(and true true)
(and true false)
(or true false)
(or false false)
(not false)

(> 10 9)
(< -1 0)
(= 42 9)

(>= 10 10)
(<= -1 0)
(string? "design" "tinker") ; This will NOT work
(string=? "design" "tinker")



; Input and Output
(define (y x) (* x x))


; Emacs Scribble mode, which is not fully-fledged.
(require (planet neil/scribble-emacs:1:3/scribble-emacs-dotemacs))

(require (planet neil/scribble-emacs:1:3))

(require (planet neil/scribble-emacs:1:3/<<file>>))

#|
Life is awesome
|#
