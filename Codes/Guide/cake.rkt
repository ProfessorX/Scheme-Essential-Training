#lang racket

(provide print-cake)
; draws a cake with n candles
(define (print-cake n)
  (show "   ~a   ~n" n #\. )
  (show " .-~a-. ~n" n #\| )
  (show " | ~a | ~n" n #\space )
  (show "---~a---~n" n #\- ))

(define (show fmt n ch)
  (printf fmt (make-string n ch))
  (newline))
