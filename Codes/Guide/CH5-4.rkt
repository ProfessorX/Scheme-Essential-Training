;; Opaque versus Transparent Structure Types
; That is, structure types by default are opaque. If the accessors and mu-
; tators of a structure type are kept private to a module, then no other module can rely on the
; representation of the type’s instances.
; To make a structure type transparent, use the #:transparent keyword after the field-name
; sequence

(struct posn (x y))

(struct posn (x y)
        #:transparent)
; test
(posn 1 2)
