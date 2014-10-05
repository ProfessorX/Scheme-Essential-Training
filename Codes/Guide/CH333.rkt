#|
The previous chapter introduced some of Racket’s built-in datatypes: numbers, booleans,
strings, lists, and procedures. This section provides a more complete coverage of the built-in
datatypes for simple forms of data.
|#

;; Booleans
(= 2 (+ 1 1))
(boolean? #t)
(boolean? #f)
(boolean? "no")

(if "no"
    1
    0)

;; Numbers
0.5
#e0.5
#x03BB

(/ 1 2)
(/ 1 2.0)
(if (= 3.0 2.999)
    1
    2)
(inexact->exact 0.1)  ; fun, isn't it?
(sin 0)  ; rational
(sin 1/2)  ; not rational

(define (sigma f a b)
  (if (= a b)
      0
      (+ (f a) (sigma f (+ a 1) b))))
; test
(time (round (sigma (λ (x) (/ 1 x)) 1 2000)))
(time (round (sigma (λ (x) (/ 1.0 x)) 1 2000)))

(integer? 5)
(integer-length 5)
(complex? 5)
(integer? 5.0)
(integer? 1+2i)
(complex? 1+2i)
(complex? 1.0+2.0i)
(abs -5)
(abs -5+2i)
(sin -5+2i)

(= 1 1.0)
(equal? 1 1.0)
(eqv? 1 1.0)

; something interesting
(= 1/2 0.5)
(= 1/10 0.1)
(inexact->exact 0.1)

;; Characters
; A Racket character corresponds to a Unicode scalar value.
(integer->char 65)
(char->integer #\A)
#\λ
#\u03BB
(integer->char 17)
(char->integer #\space)

; The display procedure directly writes a character to the current output port
#\A
(display #\A)

(char-alphabetic? #\A)
(char-numeric? #\0)
(char-whitespace? #\newline)
(char-downcase #\A)
(char-upcase #\b)

(char=? #\a #\A)
(char-ci=? #\a #\A)
(eqv? #\a #\A)


;; Strings
; A string is a fixed-length array of characters. It prints using doublequotes, where double-
; quote and backslash characters within the string are escaped with backslashes.
"Apple"
"\u03BB"
(display  "\u03BB")
(display "Apple")
(display "a \"quoted\" thing")
(display "two\nlines")

(string-ref "Apple" 0)
(string-ref "Apple" 9)  ; Oops!
(define s (make-string 5 #\.))
s
(string-set! s 2 #\λ)
s

; String ordering
(string<? "apple" "Banana")
(string-ci<? "apple" "Banana")
(string-upcase "StarBe")
(parameterize ([current-locale "C"])
  (string-locale-upcase "StraBe"))

;; Bytes and Byte Strings
; A byte is an exact integer between 0 and 255, inclusive.
(byte? 0)
(byte? 256)
#"Apple"
(bytes-ref #"Apple" 0)
(make-bytes 3 65)
(define b (make-bytes 2 0))
; test
b

(bytes-set! b 0 1)
(bytes-set! b 1 255)
b

(display #"Apple")
(display "\316\273")
(display #"\316\273")

(bytes->string/utf-8 #"\316\273")
(bytes->string/latin-1 #"\316\273")
(parameterize ([current-locale "C"])  ; C locale supports ASCII only
  (bytes->string/locale #"\316\273")) 

(let ([cvt (bytes-open-converter "cp1253"
                                 "UTF-8")]
      [dest (make-bytes 2)])
  (bytes-convert cvt #"\353" 0 1 dest)
  (bytes-close-converter cvt)
  (bytes->string/utf-8 dest))

;; Symbols
; A symbol is an atomic value that prints like an identifier preceded with '
; An expression that starts with ' and continues with an identifier produces a symbol value.
'a
(symbol? 'a)
(eq? 'a 'a)
(eq? 'a (string->symbol "a"))
(eq? 'a 'b)
(eq? 'a 'A)
#ci'A

(string->symbol "one, two")
(string->symbol "6")

(write 'Apple)
(display 'Apple)
(write '|6|)
(display '|6|)

(define s (gensym))
s
(eq? s 'g223)
(eq? 'a (string->uninterned-symbol "a"))

;; Keywords












