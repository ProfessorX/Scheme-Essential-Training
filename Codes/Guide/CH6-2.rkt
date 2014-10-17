;; Module Syntax
; (module name-id initial-module-path
;   decl ...)
; where the name-id is a name for the module, initial-module-path is an initial import,
; and each decl is an import, export, definition, or expression. In the case of a file, name-id
; normally matches the name of the containing file, minus its directory path or file extension,
; but name-id is ignored when the module is required through its file’s path.

(module cake racket
  (provide print-cake)
  (define (print-cake n)
    (show "   ~a   ~n" n #\. )
    (show " .-~a-. ~n" n #\| )
    (show " | ~a | ~n" n #\space )
    (show "---~a---~n" n #\- ))
  (define (show fmt n ch)
    (printf fmt (make-string n ch))
    (newline)))

; Yet more stuff
(require 'cake)
(print-cake 3)

(module hi racket
  (printf "Hello\n"))

; The #lang Shorthand
; (module* name-id initial-module-path-or-#f
;   decl ...)

#|
A submodule declared with module can be required by its enclosing module, but the
submodule cannot require the enclosing module or lexically reference the enclosing
module’s bindings.

A submodule declared with module* can require its enclosing module, but the en-
closing module cannot require the submodule.
|#

; (module+ name-id
;   decl ...)

; Using module+ instead of module* allows tests to be interleaved with function definitions.

