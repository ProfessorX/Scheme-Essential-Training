;; More Structure Type Options
; (struct struct-id maybe-super (field ...)
;         struct-option ...)
; maybe-super = empty | super-id
; field = field-id | [field-id field-option ...]
; The full syntax of struct supports many options, both at the structure-type level and at the
; level of individual fields and A struct-option always starts with a keyword

#:mutable
#|
Causes all fields of the structure to be mutable, and introduces for
each field-id a mutator set-struct-id -field-id ! that sets
the value of the corresponding field in an instance of the structure
type.
|#
(struct dot (x y) #:mutable)
(define d (dot 1 2))
(dot-x d)
(dot-y d)
(set-dot-x! d 10)
(dot-x d)

; The #:mutable option can also be used as a field-option , in
; which case it makes an individual field mutable.
(struct person (name [age #:mutable]))
(define friend (person "Barney" 5))
(set-person-age! friend 6)
(set-person-name! friend "Mary")  ; this will NOT work

#:transparent

; #:inspector inspector-expr
; Generalizes #:transparent to support more controlled access to
; reflective operations.

#:prefab

#:auto-value auto-expr
(struct posn (x y [z #:auto])
        #:transparent
        #:auto-value 0)
(posn 1 2)

#:guard guard-expr
; Specifies a constructor guard procedure to be called whenever an
; instance of the structure type is created.
(struct thing (name)
        #:transparent
        #:guard (lambda (name type-name)
                  (cond
                   [(string? name) name]
                   [(symbol? name) (symbol->string name)]
                   [else (error type-name "bad name: ~e" name)])))
; test
(thing "apple")
(thing 'apple)
(thing 1/2)

; The guard is called even when subtype instances are created.
(struct person thing  (age)
        #:transparent
        #:guard (lambda (name age type-name)
                  (if (negative? age)
                      (error type-name "bad age: ~e" age)
                      (values name age))))
(person "John" 10)
(person "Mary" -1)
(person 10 10)


#:methods interface-expr [body ...]
; Associates method definitions for the structure type that correspond
; to a generic interface.
(struct cake (candles)
        #:methods gen:custom-write
        [(define (write-proc cake port mode)
           (define n (cake-candles cake))
           (show "   ~a   ~n" n #\. port)
           (show " .-~a-. ~n" n #\| port)
           (show " | ~a | ~n" n #\space port)
           (show "---~a---~n" n #\- port))
         (define (show fmt n ch port)
           (fprintf port fmt (make-string n ch)))])
; test
(display (cake 6))

#:property prop-expr val-expr
; Associates a property and value with the structure type. 

(struct greeter (name)
        #:property prop:procedure
        (lambda (self other)
          (string-append
           "Hi " other
           ", I'm " (greeter-name self))))

(define joe-greet (greeter "Joe"))
(greeter-name joe-greet)
(joe-greet "Mary")
(joe-greet "John")

#:super super-expr
; An alternative to supplying a super-id next to struct-id. Instead
; of the name of a structure type (which is not an expression), super-
; expr should produce a structure type descriptor value.

(define (raven-constructor super-type)
  (struct raven ()
          #:super super-type
          #:transparent
          #:property prop:procedure (lambda (self) 'nevermore))
  raven)
; test
(let ([r ((raven-constructor struct:posn) 1 2)])
  (list r (r)))

(let ([r ((raven-constructor struct:thing) "apple")])
  (list r (r)))

