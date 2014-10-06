;; Identifiers and Bindings
#lang racket
; within the module, the identifiers described in this guide start with the meaning
; described here

; Forms like define, lambda, and let associate a meaning with one or more identifiers;
; that is, they bind identifiers.
(define f
  (λ (x)
     (let ([y 5])
       (+ x y))))

(f 10)
(f 998)

#|
the define is a binding of f, the lambda has a binding for x, and the let has a binding for
y. The scope of the binding for f is the entire module; the scope of the x binding is (let
([y 5]) (+ x y)); and the scope of the y binding is just (+ x y). The environment of
(+ x y) includes bindings for y, x, and f, as well as everything in racket.
|#

(define f
  (λ (append)
     (define cons (append "ugly" "confusing"))
     (let ([append 'this-was])
       (list append cons))))
(f list)

define 
(let ([define 5]) define)

; Again, shadowing standard bindings in this way is rarely a good idea, but the possibility is
; an inherent part of Racket’s flexibility.

