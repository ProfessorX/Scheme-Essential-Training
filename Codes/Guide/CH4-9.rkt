;; Assignment: set!
; (set! id expr)
; A set! expression evaluates expr and changes id (which must be bound in the enclosing
; environment) to the resulting value. The result of the set! expression itself is #<void>.


(define greeted null)
(define (greet name)
  (set! greeted (cons name greeted))
  (string-append "Hello, " name))
; test
(greet "Athos")
(greet "Porthos")
(greet "Aramis")
greeted  ; do NOT need braces here
(greeted)

(define (make-running-total)
  (let ([n 0])
    (lambda ()
      (set! n (+ n 1))
      n)))
(define win (make-running-total))
(define lose (make-running-total))
; test
(win)
(lose)
(win)
(win)

; Guidelines for using Assignment

; Really Awful example
(define name "unknown")
(define result "unknown")
(define (greet)
  (set! result (string-append "Hello, " name)))
;test
(set! name "John")
name
(greet)
result

; OK example
(define (greet name)
  (string-append "Hello, " name))
; test
(greet "John")
(greet "Anna")

; Bad example
(let ([tree 0])
  (set! tree (list tree 1 tree))
  (set! tree (list tree 2 tree))
  (set! tree (list tree 3 tree))
  tree)
; OK example
(let* ([tree 0]
       [tree (list tree 1 tree)]
       [tree (list tree 2 tree)]
       [tree (list tree 3 tree)])
  tree)

; Using assignment to accumulate results from an iteration is bad style.
; Somewhat bad example
(define (sum lst)
  (let ([s 0])
    (for-each (lambda (i) (set! s (+ i s)))
              lst)
    s))
; test
(sum '(1 2 3))
; OK example
(define (sum lst)
  (let loop ([lst lst] [s 0])
    (if (null? lst)
        s
        (loop (cdr lst) (+ s (car lst))))))
; test
(sum '())
sum
(sum '(1 2 3 998))

; Better
(define (sum lst)
  (apply + lst))
; test
(sum '(1 2 998))

; Good (a general approach) example
(define (sum lst)
  (for/fold ([s 0])
      ([i (in-list lst)])
    (+ s i)))
; test
(sum '(1 2 3 4 5))
(sum '( 2 3 998))

; OK example
(define next-number!
  (let ([n 0])
    (lambda ()
      (set! n (add1 n))
      n)))
; test
(next-number!)
(next-number!)
(next-number!)

#|
All else being equal, a program that uses no assignments or mutation is always preferable
to one that uses assignments or mutation. While side effects are to be avoided, however,
they should be used if the resulting code is significantly more readable or if it implements a
significantly better algorithm.
|#

; Multiple Values: set!-values
; (set!-values (id ...) expr)
(define game
  (let ([w 0]
        [l 0])
    (lambda (win?)
      (if win?
          (set! w (+ w 1))
          (set! l (+ l 1)))
      (begin0
          (values w l)
        (set!-values (w l) (values l w))))))
; test
(game #t)
(game #t)
(game #f)


