;; for and for*
; (for (clause ...)
;   (body ...+))
; clause = [id sequence-expr] | #:when boolean-expr | #:unless boolean-expr


#|

When multiple [id sequence-expr ] clauses are provided in a for form, the correspond-
ing sequences are traversed in parallel:
|#
(for ([i (in-range 1 5)]
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "Chapter ~a . ~a\n" i chapter))  ; Noticed something interesting?


#|
With parallel sequences, the for expression stops iterating when any sequence ends. This
behavior allows **in-naturals**, which creates an infinite sequence of numbers, to be used
for indexing:
|#
(for ([i (in-naturals 1)]
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "CHapter ~a . ~a\n" i chapter))


#|
The for* form, which has the same syntax as for, nests multiple sequences instead of
running them in parallel:
|#
(for* ([book '("Guide" "Reference")]
       [chapter '("Intro" "Details" "Conclusion")])
  (printf "~a ~a\n" book chapter))


; revised
; It allows the body to evaluate only when the boolean-expr produces a true value
(for* ([book '("Guide" "Reference")]
       [chapter '("Intro" "Details" "Conclusion")]
       #:when (not (equal? chapter "Details")))
  (printf "~a ~a\n" book chapter))

#|
A boolean-expr with #:when can refer to any of the preceding iteration bindings. In a
for form, this scoping makes sense only if the test is nested in the iteration of the preceding
bindings; thus, bindings separated by #:when are mutually nested, instead of in parallel,
even with for.
|#

(for ([book '("Guide" "Reference" "Notes")]
       #:when (not (equal? book "Notes"))
       [i (in-naturals 1)]
       [chapter '("Intro" "Details" "Conclusion" "Index")]
       #:when (not (equal? chapter "Index")))
  (printf "~a Chapter ~a. ~a\n" book i chapter))



