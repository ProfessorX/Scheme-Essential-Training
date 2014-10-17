;; Copying and Update
; (struct-copy struct-id struct-expr [field-id expr] ...)

(define p1 (posn 1 2))
(define p2 (struct-copy posn p1 [x 3]))
(list (posn-x p2) (posn-y p2))
(list (posn-x p1) (posn-y p2))

#|
The struct-id that appears after struct-copy must be a structure type name bound by
struct (i.e., the name that cannot be used directly as an expression). The struct-expr
must produce an instance of the structure type. The result is a new instance of the structure
type that is like the old one, except that the field indicated by each field-id gets the value
of the corresponding expr .
|#

