#lang web-server/insta
; A "Hello World" web server
(define (start request)
  (response/xexpr
   '(html
     (body "Hello World"))))
 
