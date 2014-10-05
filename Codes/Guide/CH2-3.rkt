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
(first '(1 2 3))
(rest (list 1 2 3))
#| 
 To create a new node for a linked list—that is, to add to the front of the list—use the cons
 function, which is short for “construct.” To get an empty list to start with, use the empty
 constant
 |#
empty
(cons "head" empty)
(cons "dead" (cons "head" empty))

(empty? empty)
(empty? (cons "head" empty))
(cons? empty)
(cons? (cons "head" empty))


(car 1 2)  ; not working
(car '(1 2))
(car (cons 2 3))

; Your own version of the length function
(define (my-length lst)
  (cond
   [(empty? lst) 0]
   [else (+ 1 (my-length (rest lst)))]))
; test
(my-length empty)
(my-length (list "a" "b" "c"))

(define (my-map f lst)
  (cond
   [(empty? lst) empty]
   [else (cons (f (first lst))
               (my-map f (rest lst)))]))
; test
(my-map string-upcase (list "ready" "set" "go"))

;; VIP: Tail Recursion
(my-length '("a" "b" "c"))

#|
You can avoid piling up additions by adding along the way. To accumulate a length this way,
we need a function that takes both a list and the length of the list seen so far
|#
(define (my-length lst)
  ; local function iter
  (define (iter lst len)
    (cond
     [(empty? lst) len]
     [else (iter (rest lst) (+ len 1))]))
  ; body of my-length calls iter
  (iter lst 0))

#|
In the case of my-map, O(n) space complexity is reasonable, since it has to generate a result
of size O(n). Nevertheless, you can reduce the constant factor by accumulating the result
list. The only catch is that the accumulated list will be backwards, so you’ll have to reverse
it at the very end
|#
(define (my-map f lst)
  (define (iter lst backward-result)
    (cond
     [(empty? lst) (reverse backward-result)]
     [else (iter (rest lst)
                 (cons (f (first lst))
                       backward-result))]))
  (iter lst empty))


;; Recursion vs Iteration
(define (remove-dups l)
  (cond
   [(empty? l) empty]  ; empty
   [(empty? (rest l)) l]  ; single element
   [else
    (let ([i (first l)])
      (if (equal? i (first (rest l)))  ; see if consecutive duplicate
          (remove-dups (rest l))  ; dupl! Remove the mother fucker!
          (cons i (remove-dups (rest l)))))]))
; test
(remove-dups (list "a" "b" "b" "b" "c" "c"))
(remove-dups (list "a" "b" "b" "b" "b"))

;; Pairs, Lists and Racket Syntax
(cons 1 2)
(cons "banana" "split")
(pair? (cons 1 2))  ; Strange? not at all.
(pair? (list 1 2 3))  ; Strange? not at all.
(car (cons 1 2))
(cdr (cons 1 2))
(pair? empty)

(cons (list 2 3) 1)  ; not working
(cons 1 '(2 3))

#|
Non-list pairs are used intentionally, sometimes. For example, the make-hash function takes
a list of pairs, where the car of each pair is a key and the cdr is an arbitrary value.
|#
(cons 0 (cons 1 2))
'(0 . (1 . 2))

#|
A list prints with a quote mark before it, but if an element of a list is itself a list, then no
quote mark is printed for the inner list
|#
(list (list 1) (list 2 3) (list 4))
(quote ("red" "green" "blue"))
(quote ((1) (2 3) (4)))
(quote ())

(quote (1 . 2))
(quote (0 . (1 . 2)))

; Naturally, list of any kind can be nested
(list (list 1 2 3) 5 (list "a" "b" "c"))
(quote ((1 2 3) 5 ("a" "b" "c")))

(quote jane-doe)

; A value that prints like a quoted identifier is a symbol.
map
(quote map)
(symbol? (quote map))
(symbol? map)
(string->symbol "map")
(symbol->string (quote map))
(symbol->string 'map)  ; these two are the same

#|
In the same way that quote for a list automatically applies itself to nested lists, quote on a
parenthesized sequence of identifiers automatically applies itself to the identifiers to create
a list of symbols
|#
(car (quote (road map)))
(car '(road map))
(symbol? (car '(road map)))

(quote (road map))
; The quote form has no effect on a literal expression such as a number or string
(quote 42)
'42
'"on the record"
(quote "on the record")

;; Abbreviating quote with '
'(1 2 3)
'road
'((1 2 3) road ("a" "b" "c"))
(car ''road)
(car '(quote road))
(quote (quote road))
'(quote road)
''road

;; Lists and Racket Syntax
(+ 1 . (2))
(1 .<. 2)  ; not working
(1 . < . 2)
'(1 . < . 2)






