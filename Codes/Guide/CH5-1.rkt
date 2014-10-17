;;; Programmer-Defined Datatypes
; New datatypes are normally created with the struct form, which is the topic of this chapter.
; The class-based object system, which we defer to §13 “Classes and Objects”, offers an al-
; ternate mechanism for creating new datatypes, but even classes and objects are implemented
; in terms of structure types.


;; Simple Structure Types: struct
; (struct struct-id (field-id ...))
(struct posn (x y))
(posn 1 2)
(posn? 3)
(posn? (posn 1 2))
(posn-x (posn 1 2))
(posn-y (posn 1 2))

