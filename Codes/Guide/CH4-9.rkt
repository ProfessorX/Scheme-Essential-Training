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

