;; Quasiquoting: quasiquote and `
; (quasiquote datum)
; However, for each (unquote expr ) that appears within the datum , the expr is evaluated
; to produce a value that takes the place of the unquote sub-form.
(quasiquote (1 2 (unquote (+ 1 2)) (unquote (- 5 1))))

; This form can be used to write functions that build lists according to certain patterns.

(define (deep n)
  (cond
   [(zero? n) 0]
   [else
    (quasiquote ((unquote n) (unquote (deep (- n 1)))))]))
; test
(deep 998)

#|
Or even to cheaply construct expressions programmatically. (Of course, 9 times out of 10,
you should be using a macro to do this (the 10th time being when you’re working through a
textbook like PLAI).)
|#
(define (build-exp n)
  (add-lets n (make-sum n)))

(define (add-lets n body)
  (cond
   [(zero? n) body]
   [else
    (quasiquote
     (let ([(unquote (n->var n)) (unquote n)])
       (unquote (add-lets (- n 1) body))))]))

(define (make-sum n)
  (cond
   [(= n 1) (n->var 1)]
   [else
    (quasiquote (+ (unquote (n->var n))
                   (unquote (make-sum (- n 1)))))]))

(define (n->var n) (string->symbol (format "x~a" n)))
; test
(build-exp 3)

#|
The unquote-splicing form is similar to unquote, but its expr must produce a list, and
the unquote-splicing form must appear in a context that produces either a list or a vector.
As the name suggests, the resulting list is spliced into the context of its use.
|#
(quasiquote (1 2 (unquote-splicing (list (+ 1 2) (- 5 1))) 5))

(define (build-exp n)
  (add-lets
   n
   (quasiquote (+ (unquote-splicing
                   (build-list
                    n
                    (lambda (x) (n->var (+ x 1)))))))))

(define (add-lets n body)
  (quasiquote
   (let (unquote
         (build-list
          n
          (lambda (n)
            (quasiquote
             [(unquote (n->var (+ n 1))) (unquote (+ n 1))]))))
     (unquote body))))

(define (n->var n)
  (string->symbol (format "x~a" n)))
; test
(build-exp 3)

(quasiquote (1 2 (quasiquote (unquote (+ 1 2)))))
(quasiquote (1 2 (quasiquote (unquote (unquote (+ 1 2))))))
(quasiquote (1 2 (quasiquote ((unquote (+ 1 2)) (unquote (unquote (- 5 1)))))))

#|
The evaluations above will not actually print as shown. Instead, the shorthand form of
quasiquote and unquote will be used: ` (i.e., a backquote) and , (i.e., a comma). The
same shorthands can be used in expressions
|#

`(1 2 `(,(+ 1 2) ,,(- 5 1)))

; The shorthand form of unquote-splicing is ,@
`(1 2 ,@(list (+ 1 2) (- 5 1)))
