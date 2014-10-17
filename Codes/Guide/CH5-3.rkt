;; Structure Subtypes
; (struct struct-id super-id (field-id ...))

(struct posn (x y))
(struct 3d-posn posn (z))
; A structure subtype inherits the fields of its supertype, and the subtype constructor accepts
; the values for the subtype fields after values for the supertype fields. An instance of a struc-
; ture subtype can be used with the predicate and accessors of the supertype.

(define p (3d-posn 1 2 3))
; test
p
(posn? p)
(posn-x p)
(3d-posn-z p)

