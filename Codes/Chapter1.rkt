; Arithmetic
;; Arithmetic of strings
(define prefix "Hello")
(define suffix "World")

;Wrong  (prefix + "_" + suffix)  
; Wrong (+ (prefix "_") suffix)
(string-append prefix "_" suffix)

;; Wolla, it works!
(define str "HelloWorld!")
(define i 5)
(string-append 
 (substring str 0 (- i 1))
 "_"
 (substring str i))

;; Arithmetic on images
(require 2htdp/image)
(ellipse 10 20 "solid" "green")
