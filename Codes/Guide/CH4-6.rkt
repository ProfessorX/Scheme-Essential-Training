;; Local Binding
; Although internal defines can be used for local binding, Racket provides three forms that
; give the programmer more control over bindings: let, let*, and letrec.


; Parallel Binding: let
; (let ([id expr] ...) body ...+)
; The id s are bound “in parallel.” That is, no id is bound in the right-hand side expr for any
; id , but all are available in the body . The id s must be different from each other.
(let ([me "Bob"])
  me)
(let ([me "Bob"]
      [myself "Robert"]
      [I "Bobby"])
  (list me myself I))
; this will NOT work
(let ([me "Bob"]
      [me "Robert"])
  me)

; The fact that an id ’s expr does not see its own binding is often useful for wrappers that
; must refer back to the old value
(let ([+ (lambda (x y)
           (if (string? x)
               (string-append x y)
               (+ x y)))])
  (list (+ 1 2)
        (+ "see" "saw")))

(let ([me "Tarzan"]
      [you "Jane"])
  (let ([me you]
        [you me])
    (list me you)))

; Sequential Binding: let*
; (let ([id expr] ...) body ...+)
(let* ([x (list "Borroughs")]
       [y (cons "Rice" x)]
       [z (cons "Edgar" y)])
  (list x y z))
(let* ([name (list "Borroughs")]
       [name (cons "Rice" name)]
       [name (cons "Edgar" name)])
  name)

; Recursive Binding: lecrec
; (letrec ([id expr] ...) 
;   body ...+)
#|
While let makes its bindings available only in the body s, and let* makes its bind-
ings available to any later binding expr , letrec makes its bindings available to all other
expr s—even earlier ones. In other words, letrec bindings are recursive.
|#
(letrec ([swing
          (lambda (t)
            (if (eq? (car t) 'tarzan)
                (cons 'vine
                      (cons 'tarzan (cddr t)))
                (cons (car t)
                      (swing (cdr t)))))])
  (swing '(vine tarzan vine vine)))

(letrec ([tarzan-near-top-of-tree?
          (lambda (name path depth)
            (or (equal? name "tarzan")
                (and (directory-exists? path)
                     (tarzan-in-directory? path depth))))]
         [tarzan-in-directory?
          (lambda (dir depth)
            (cond
             [(zero? depth) #f]
             [else
              (ormap
               (lambda (elem)
                 (tarzan-near-top-of-tree? (path-element->string elem)
                                           (build-path dir elem)
                                           (- depth 1)))
               (directory-list dir))]))])
  (tarzan-near-top-of-tree? "tmp"
                            (find-system-path 'temp-dir)
                            4))

(letrec ([quicksand quicksand])
  quicksand)


; Named let
; (let proc-id ([arg-id init-expr] ...)
;   body ...+)
; This is EQUIVALENT to 
; (letrec ([proc-id (lambda (arg-id ...)
;                     body ...+)])
;   (proc-id init-expr))

(define (duplicate pos lst)
  (let dup ([i 0]
            [lst lst])
    (cond
     [(= i pos) (cons (car lst) lst)]
     [else (cons (car lst) (dup (+ i 1) (cdr lst)))])))
; test
(duplicate 1 (list "apple" "cheese burger!" "banana"))


; Multiple Values: let-values, let*-values, letrec-values
; (let-values ([(id ...) expr] ...)
;   body ...+)
; (let*-values ([(id ...) expr] ...)
;   body ...+)
; (letrec-values ([(id ...) expr] ...)
;   body ...+)

(let-values ([(q r) (quotient/remainder 14 3)])
  (list q r))
