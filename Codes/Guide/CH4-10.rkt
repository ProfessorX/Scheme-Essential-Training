;; Quoting: quote and '
; (quote datum)
; The syntax of a datum is technically specified as anything that the read function parses as
; a single element. The value of the quote form is the same value that read would produce
; given datum .

(quote apple)
(quote #t)
(quote 42)
(quote "hello")
(quote ())
(quote ((1 2 3) #("z" x) . the-end))
(quote (1 2 . (3)))

; 'datum
; is just a shorthand for (quote datum)
'apple
'"Hello"
'(1 2 3)
(display '(you can 'me))
