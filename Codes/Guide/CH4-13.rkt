; Dynamic Binding: parameterize
; (parameterize ([parameter-expr value-expr] ...)
;   body ...+)
; The parameterize form associates a new value with a parameter during the evaluation of
; body expressions
(parameterize ([error-print-width 5])
  (car (expt 10 1024)))
(parameterize ([error-print-width 10])
  (car (expt 10 1024)))

(define location (make-parameter "here"))
(location)

(parameterize ([location "there"])
  (location))
(location)
(parameterize ([location "in a house"])
  (list (location)
        (parameterize ([location "with a mouse"])
          (location))
        (location)))

(parameterize ([location "in a box"])
  (car (location)))

(location)

; A parameterize form adjusts the value of a parameter
; during the whole time that the parameterize body is evaluated
(define (would-you-could-you?)
  (and (not (equal? (location) "here"))
       (not (equal? (location) "there"))))
; test
(would-you-could-you?)
(parameterize ([location "on a bus"])
  (would-you-could-you?))

(let ([get (parameterize ([location "with a fox"])
                   (lambda () (location)))])
  (get))

; The current binding of a parameter can be adjusted imperatively by calling the parameter as
; a function with a value.
(define (try-again! where)
  (location where))
; test
(location)
(parameterize ([location "on a train"])
  (list (location)
        (begin (try-again! "in a boat!")
               (location))))
(location)

#|
Using parameterize is generally preferable to updating a parameter value imperatively—
for much the same reasons that binding a fresh variable with let is preferable to using set!
(see §4.9 “Assignment: set!”).
|#

(define lokation "Mother")

(define (would-ya-could-ya?)
  (and (not (equal? lokation "here"))
       (not (equal? lokation "there"))))
; test
(set! lokation "Mother Fucker")
(would-ya-could-ya?)
