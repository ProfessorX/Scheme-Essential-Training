;; Datatypes and Serialization
#|
Prefab structure types (see §5.7 “Prefab Structure Types”) automatically support serializa-
tion: they can be written to an output stream, and a copy can be read back in from an input
stream
|#
(define-values (in out) (make-pipe))

(write #s(sprout bean) out)

(read in)

#|
Other structure types created by struct, which offer more abstraction than prefab structure
types, normally write either using #<....> notation (for opaque structure types) or using
#(....) vector notation (for transparent structure types). In neither can the result be read
back in as an instance of the structure type
|#

(struct posn (x y))

(write (posn 1 2))

(define-values (in out) (make-pipe))

(write (posn 1 2) out)

(read in)

(struct posn (x y) #:transparent)

(write  (posn 1 2))

(define-values (in out) (make-pipe))

(write (posn 1 2) out)

(define v (read in))
; test
v
(posn? v)
(vector? v)


#|
The serializable-struct form defines a structure type that can be serialized to a
value that can be printed using write and restored via read. The serialized result can be
deserialized to get back an instance of the original structure type. The serialization form
and functions are provided by the racket/serialize library.
|#

(require racket/serialize)

(serializable-struct posn (x y) #:transparent)

(deserialize (serialize (posn 1 2)))

(write (serialize (posn 1 2)))

(define-values (in out) (make-pipe))

(write (serialize (posn 1 2)) out)

(deserialize (read in))
