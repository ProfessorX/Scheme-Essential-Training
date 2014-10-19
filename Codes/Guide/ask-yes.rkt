#lang racket/gui

(define (ask-yes-or-no-question question
                                #:default answer
                                #:title title
                                #:width w
                                #:height h)
  (define d (new dialog% [label title] [width w] [height h]))
  (define msg (new message% [label question] [parent d]))
  (define (yes) (set! answer #t) (send d show #f))
  (define (no) (set! answer #f) (send d show #f))
  (define yes-b (new button%
                     [label "Yes"] [parent d]
                     [callback (lambda (x y) (yes))]
                     [style (if answer '(border) '())]))
  (define no-b (new button%
                    [label "No"] [parent d]
                    [callback (lambda (x y) (no))]
                    [style (if answer '() '(border))]))
  (send d show #t)
  answer)

(provide (contract-out
          [ask-yes-or-no-question
           (-> string?
               #:default boolean?
               #:title string?
               #:width exact-integer?
               #:height exact-integer?
               boolean?)]))
