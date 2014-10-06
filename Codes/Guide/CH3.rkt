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
; A keyword value is similar to a symbol 
(string->keyword "apple")
'#:apple
(eq? '#:apple (string->keyword "apple"))

not-a-symbol-expression
#:not-a-symbol-expression
(define dir (find-system-path 'temp-dir))  ; not '#:temp-dir
(with-output-to-file (build-path dir "stuff.txt")
  (λ () (printf "example\n"))
  ; optional #:mode argument can be 'text or 'binary
  #:mode 'text
  ; optional #:exists argument can be 'replace, 'truncate
  #:exists 'replace)

;; Pairs and Lists
(cons 1 2)
(cons (cons 1 2) 3)
(car (cons 1 2))
(cdr (cons 1 2))
(pair? (cons 1 2))

null
(cons 0 (cons 1 (cons 2 null)))
(list? null)
(list? (cons 1 (cons 2 null)))
(list? (cons 1 2))

(srcloc "file.rkt" 1 0 1 (+ 4 4))
(list 'here (srcloc "file.rkt" 1 0 1 9) 'there)
(cons 1 (srcloc "file.rkt" 1 0 1 8))
(cons 1 (cons 2 (srcloc "file.rkt" 1 0 1 8)))

(write (cons 1 2))
(display (cons 1 2))
(write null)
(display null)
(write (list 1 2 "3"))
(display (list 1 2 "3"))

;; VIP: This note matters a lot!
; Among the most important predefined procedures on lists are those that iterate through the
; list’s elements
(map (λ (i) (/ 1 i))
     '(1 2 3))
(andmap (λ (i) (i . < . 3))
        '(1 2 3))
(ormap (λ (i) (i . < . 3))
       '(1 2 3))
(ormap (λ (i) (< i 3))
       '(1 2 3))  ; this is the same as above
(filter (λ (i) (i . < . 3))
        '(1 2 3))
(foldl (λ (v i) (+ v i))
       10
       '(1 2 3))
(for-each (λ (i) (display i))
          '(1 2 3 4 998))
(member "Keys"
        '("Florida" "Keys" "U.S.A"))

(assoc 'where
       '((when "3:30") (where "Florida") (who "Mickey")))

(define p (mcons 1 2))
p
(pair? p)
(mpair? p)
(set-mcar! p 0)
p
(write p)

;; Vectors
; A vector is a fixed-length array of arbitrary values. 
#("a" "b" "c")
#(name (that tune))
#4(baldwin bruce)  ; not working on dbg, working on REPL
(vector-ref #("a" "b" "c") 1)
(vector-ref #(name (that tune)) 1)
(list->vector (map string-titlecase 
                   (vector->list #("three" "blind" "mice"))))

;; Hash Tables
#|
A hash table implements a mapping from keys to values, where both keys and values can
be arbitrary Racket values, and access and update to the table are normally constant-time
operations.
|#
(define ht (make-hash))
(hash-set! ht "apple" '(red round))
(hash-set! ht "banana" '(yellow long))

(hash-ref ht "apple")
(hash-ref ht "coconut")  ; this will not work
(hash-ref ht "coconut" "not there")

(define ht (hash "apple" 'red "banana" 'yellow))
(hash-ref ht "apple")
(define ht2 (hash-set ht "coconut" 'brown))
(hash-ref ht "coconut")
(hash-ref ht2 "coconut")

(define ht #hash(("apple" . red)
                 ("banana" . yellow)))
(hash-ref ht "apple")

#hash(("apple" . red)
      ("banana" . yellow))  ; use this in REPL, direct eval will not work

(hash 1 (srcloc "file.rkt" 1 0 1 (+ 4 4)))

; A mutable hash table can optionally retain its keys weakly, so each mapping is retained only
; so long as the key is retained elsewhere.
(define ht (make-weak-hasheq))
(hash-set! ht (gensym) "can you see me?")
(collect-garbage)
(hash-count ht)

(let ([g (gensym)])
  (hash-set! ht g (list g)))
(collect-garbage)
(hash-count ht)

(define ht (make-weak-hasheq))
(let ([g (gensym)])
  (hash-set! ht g (make-ephemeron g (list g))))
(collect-garbage)
(hash-count ht)

;; Box
; A box is like a single-element vector. It has no practical usage.
(define b (box "apple"))
b
(unbox b)
(set-box! b '(banana boat))
b

;; Void and Undefined
(void)
(void 1 2 3)
(list (void))

(define (fails)
  (define x x)
  x)

(fails)




















