;; Structure Type Generativity
; Each time that a struct form is evaluated, it generates a structure type that is distinct from
; all existing structure types, even if some other structure type has the same name and fields.
; This generativity is useful for enforcing abstractions and implementing programs such as
; interpreters, but beware of placing a struct form in positions that are evaluated multiple
; times.

(define (add-bigger-fish lst)
  (struct fish (size) #:transparent)  ; new everytime
  (cond
   [(null? lst) (list (fish 1))]
   [else
    (cons (fish (* 2 (fish-size (car lst))))
          lst)]))
; test
(add-bigger-fish null)
(add-bigger-fish (add-bigger-fish null))

; Modification
(struct fish (size) #:transparent)
(define (add-bigger-fish lst)
  (cond
   [(null? lst) (list (fish 1))]
   [else
    (cons (fish (* 2 (fish-size (car lst))))
          lst)]))
; test
(add-bigger-fish (add-bigger-fish null))
