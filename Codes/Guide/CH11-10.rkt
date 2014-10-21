;; Iteration Performance
#|
Ideally, a for iteration should run as fast as a loop that you write by hand as a recursive-
function invocation. A hand-written loop, however, is normally specific to a particular kind
of data, such as lists. In that case, the hand-written loop uses selectors like car and cdr
directly, instead of handling all forms of sequences and dispatching to an appropriate iterator.

fast-clause =
[id fast-seq ]
|
 [(id ) fast-seq ]
|
[(id id ) fast-indexed-seq ]
|
 [(id ...) fast-parallel-seq ]
fast-seq =
 (in-range expr )
|
(in-range expr expr )
|
 (in-range expr expr expr )
|
(in-naturals)
|
 (in-naturals expr )
|
(in-list expr )
|
 (in-vector expr )
|
(in-string expr )
|
 (in-bytes expr )
|
(in-value expr )
|
 (stop-before fast-seq predicate-expr )
|
(stop-after fast-seq predicate-expr )
fast-indexed-seq = (in-indexed fast-seq )
| (stop-before fast-indexed-seq predicate-expr )
| (stop-after fast-indexed-seq predicate-expr )
fast-parallel-seq = (in-parallel fast-seq ...)
| (stop-before fast-parallel-seq predicate-expr )
| (stop-after fast-parallel-seq predicate-expr )


|#
; fast
(time (for ([i (in-range 100000)])
        (for ([elem (in-list '(a b c d e f g h))])
          (void))))
; slower
(time (for ([i (in-range 100000)])
        (for ([elem '(a b c d e f g h)])
          (void))))
; slower
(time (let ([seq (in-list '(a b c d e f g h))])
        (for ([i (in-range 100000)])
          (for ([elem seq])
            (void)))))
