;; Simple Dispatch: case
; (case expr
;   [(datum ...+) body ...+]
;   ...)
; Each datum will be compared to the result of expr using equal?, and then the correspond-
; ing bodys are evaluated. The case form can dispatch to the correct clause in O(log N) time
; for N datums.

(let ([v (random 6)])
  (printf "~a\n" v)
  (case v
    [(0) 'zero]
    [(1) 'one]
    [(2) 'two]
    [(3 4 5) 'many]))

(case (random 6)
  [(0) 'zero]
  [(1) 'one]
  [(2) 'two]
  [else many])


