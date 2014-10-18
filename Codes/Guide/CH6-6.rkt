;; Assignment and Redefinition
#|
The use of set! on variables defined within a module is limited to the body of the defining
module. That is, a module is allowed to change the value of its own definitions, and such
changes are visible to importing modules. However, an importing context is NOT allowed to
change the value of an imported binding.
|#

(module m racket
  (provide counter increment!)
  (define counter 0)
  (define (increment!)
    (set! counter (add1 counter))))


; The prohibition on assignment of imported variables helps support modular reasoning about
; programs. For example, in the module,
(module m racket
  (provide rx:fish fishy-string?)
  (define rx:fish #rx"fish")
  (define (fishy-string? s)
    (regexp-match? s rx:fish)))

(module m racket
  (define pie 3.141592653))
; test
(require 'm)
(module m racket
  (define pie 3))


; For exploration and debugging purposes, the Racket reflective layer provides a compile-
; enforce-module-constants parameter to disable the enforcement of constants.
(compile-enforce-module-constants #f)
(module m2 racket
  (provide pie)
  (define pie 3.141592653))
(require 'm2)

(module m2 racket
  (provide pie)
  (define pie 3))
; test
pie























;;; DOES THAT MATTER
; Well, it seems that it will not hurt that much even if you are forever alone.
