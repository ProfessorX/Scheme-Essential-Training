;; Prefab Structure Types
; A prefab (“previously fabricated”) structure type is a built-in type that is known to the Racket
; printer and expression reader. Infinitely many such types exist, and they are indexed by
; name, field count, supertype, and other such details. The printed form of a prefab structure
; is similar to a vector, but it starts #s instead of just #, and the first element in the printed
; form is the prefab structure type’s name.



'#s(sprout bean)  ; this one works in REPL
'#s(sprout alfalfa)
; Like numbers and strings, prefab structures are “self-quoting,” so the quotes above are op-
; tional
#s(sprout bean)

(define lunch '#s(sprout bean))

(struct sprout (kind) #:prefab)
(sprout? lunch)
(sprout-kind lunch)
(sprout 'garlic)


