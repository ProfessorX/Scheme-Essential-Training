#lang slideshow
(define (four p)
  (define two-p (hc-append p p))
  (vc-append two-p two-p))

; Definitions
(define (square n)
  ; A semi-colon starts a line comment
  ; The expression below is the function body
  (filled-rectangle n n))

; Write programs, and get rich
(define (checker p1 p2)
  (let ([p12 (hc-append p1 p2)]
        [p21 (hc-append p2 p1)])
    (vc-append p12 p21)))


; Programming is fun, especially when using functional programming languages like this
(define (checkboard p)
  (let* ([rp (colorize p "red")]
         [bp (colorize p "black")]
         [c (checker rp bp)]
         [c4 (four c)])
    (four c4)))

; test: (checkboard (square 10))

(define (series mk)
  (hc-append 4 (mk 5) (mk 10) (mk 20)))

(series (lambda (size) (checkboard (square size))))

;(define series
;  (lambda (mk)
;    (hc-append 4 (mk 5) (mk 10) (mk 20))))

; Most Racketeers prefer to use the shorthand function form with
; define instead of expanding to lambda.

; Lexical scope
(define (rgb-series mk)
  (vc-append
   (series (lambda (sz) (colorize (mk sz) "red")))
   (series (lambda (sz) (colorize (mk sz) "green")))
   (series (lambda (sz) (colorize (mk sz) "blue")))))
  
(define (rgb-maker mk)
  (lambda (sz)
    (vc-append (colorize (mk sz) "red")
               (colorize (mk sz) "green")
               (colorize (mk sz) "blue"))))

(list "red" "green" "blue")

(list (circle 10) (square 10))

(list (list 1) (list 2 3) (list 4))

(define (rainbow p)
  (map (lambda (color)
         (colorize p color))
       (list "red" "orange" "yellow" "green" "blue" "purple")))
(apply vc-append (rainbow (square 5)))

(require slideshow/code)

(provide rainbow square)
