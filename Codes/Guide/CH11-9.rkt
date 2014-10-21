;; Breaking an Iteration
#|
(for (clause ...)
  body-or-break ... body )
clause =
[id sequence-expr ]
|
 #:when boolean-expr
|
#:unless boolean-expr
|
 break
body-or-break = body
| break
break = #:break boolean-expr
| #:final boolean-expr

That is, a #:break or #:final clause can be included among the binding clauses and
body of the iteration. Among the binding clauses, #:break is like #:unless but when
its boolean-expr is true, all sequences within the for are stopped. Among the body s,
#:break has the same effect on sequences when its boolean-expr is true, and it also pre-
vents later body s from evaluation in the current iteration.

|#

(for (
      [book '("Guide" "Story" "Reference")]
      #:unless (equal? book "Story")
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "~a ~a\n" book chapter))

; Devils are in the details.
(for (
      [book '("Guide" "Story" "Reference")]
      #:break (equal? book "Story")
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "~a ~a\n" book chapter))


(for* ([book '("Guide" "Story" "Reference")]
       [chapter '("Intro" "Details" "Conclusion")])
  #:break (and (equal? book "Story")
               (equal? chapter "Conclusion"))
  (printf "~a ~a\n" book chapter))

#|
A #:final clause is similar to #:break, but it does not immediately terminate the iteration.
Instead, it allows at most one more element to be drawn for each sequence and at most one
more evaluation of the body s.
|#

(for* ([book '("Guide" "Story" "Reference")]
       [chapter '("Intro" "Details" "Conclusion")])
  #:final (and (equal? book "Story")
               (equal? chapter "Conclusion"))
  (printf "~a ~a\n" book chapter))

(for ([book '("Guide" "Story" "Reference")]
      #:final (equal? book "Story")
      [chapter '("Intro" "Details" "Conclusion")])
  (printf "~a ~a\n" book chapter))
