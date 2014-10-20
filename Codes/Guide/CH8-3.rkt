;; Reading and Writing Racket Data
#|
• print, which prints a value in the same way that is it printed for a REPL result; and
• write, which prints a value in such a way that read on the output produces the value
back; and
• display, which tends to reduce a value to just its character or byte content—at least
for those datatypes that are primarily about characters or bytes, otherwise it falls back
to the same output as write.
|#


(print #"goodbye")
(write #"goodbye")
(display #"goodbye")

(print '("i" pod))
(write'("i" pod))
(display'("i" pod))


#|
Overall, print corresponds to the expression layer of Racket syntax, write corresponds to
the reader layer, and display roughly corresponds to the character layer.
The printf function supports simple formatting of data and text. In the format string sup-
plied to printf, ∼a displays the next argument, ∼s writes the next argument, and ∼v
prints the next argument.
|#
(define (deliver who when what)
  (printf "Items ~a for shopper ~s: ~v" who when what))
;test 
(deliver '("list") '("John") '("milk"))


#|
After using write, as opposed to display or print, many forms of data can be read back
in using read. The same values printed can also be parsed by read, but the result may
have extra quote forms, since a printed form is meant to be read like an expression.
|#
(define-values (in out) (make-pipe))

(write "Hello" out)

(read in)

(write '("alphabet" soup) out)

(read in)

(write #hash((a . "apple") (b . "banana")) out)

(read in)

(print '("alphabet" soup) out)

(read in)
