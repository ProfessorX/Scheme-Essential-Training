;; Lists, Iteration and Recursion
; Racket is a dialect of the language Lisp, whose name originally stood for “LISt Processor.”
; The built-in list datatype remains a prominent feature of the language.
(list "red" "green" "blue")
(list 1 2 3 4 5)

(length (list "hop" "skip" "jump"))  ; count elements
(list-ref (list "hop" "skip" "jump") 0)  ; extract by position
(list-ref (list "hop" "skip" "jump") 1)
(append (list "hop" "skip") (list "jump"))  ; combine lists 
(reverse (list "hop" "skip" "jump"))  ; reverse order
(member "fall" (list "hop" "skip" "jump"))  ; check for an element
(member "hop" (list "hop" "skip" "jump"))  ; check for an element


;; predefined list
; The map function uses the per-element results to create a new list
(map sqrt (list 1 4 9 16))
(map (λ (i)
        (string-append i "!"))
     (list "peanuts" "popcorn" "crackerjack"))

(andmap string? (list "a" "b" "c"))
(andmap string? (list "a" "b" 6))
(ormap number? (list "a" "b" 6))

; The filter function keeps elements for which the body result is true
(filter string? (list "a" "b" "c" 6))
(filter positive? (list 1 -2 6 7 0 998 -998.1))

; The map, andmap, ormap, and filter functions can all handle multiple lists, instead of just
; a single list. The lists must all have the same length, and the given function must accept one
; argument for each list
(map (λ (s n) (substring s 0 n))
     (list "peanuts" "popcorn" "crackerjack")
     (list 6 3 7))

; The foldl function generalizes some iteration functions. It uses the per-element function to
; both process an element and combine it with the “current” value, so the per-element function
; takes an extra first argument.
(foldl (λ (elem v)
          (+ v (* elem elem)))
       0
       '(1 2 3))

;; list iteration from scratch




