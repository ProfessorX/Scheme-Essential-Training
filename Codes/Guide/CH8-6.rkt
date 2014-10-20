;; I/O Patterns

; If you want to process individual lines of a file, then you can use for with in-lines
(define (upcase-all in)
  (for ([l (in-lines in)])
    (display (string-upcase l))
    (newline)))

(upcase-all (open-input-string
             (string-append
              "Hello, World!\n"
              "Life is fucking awesome in the UAE!\n"
              "Can you hear me, new, now?")))

#|
If you want to determine whether “hello” appears in a file, then you could search separate
lines, but it’s even easier to simply apply a regular expression (see §9 “Regular Expressions”)
to the stream:
|#

(define (has-hello? in)
  (regexp-match? #rx"hello" in))

; test
(has-hello? (open-input-string "hello"))
(has-hello? (open-input-string "goodbye"))

#|
If you want to copy one port into another, use copy-port from racket/port, which effi-
ciently transfers large blocks when lots of data is available, but also transfers small blocks
immediately if that’s all that is available:
|#

(define o (open-output-string))

(copy-port (open-input-string "broom") o)

(get-output-string o)
