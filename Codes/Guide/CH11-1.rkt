;;; Iterations and Comprehensions
#|
The for family of syntactic forms support iteration over sequences. Lists, vectors, strings,
byte strings, input ports, and hash tables can all be used as sequences, and constructors like
in-range offer even more kinds of sequences.
Variants of for accumulate iteration results in different ways, but they all have the same
syntactic shape. Simplifying for now, the syntax of for is
|#

; (for ([id sequences-expr] ...)
;   body ...+)

(for ([i '(1 2 3)])
  (display i))

(for ([i "abc"])
  (printf "~a..." i))


(for ([i 4])
  (display i))

#|
The for/list variant of for is more Racket-like. It accumulates body results into a list,
instead of evaluating body only for side effects. In more technical terms, for/list imple-
ments a list comprehension.
|#
(for/list ([i '(1 2 3)])
  (* i i))

(for/list ([i "abc"])
  i)

(for/list ([i 4])
  i)


