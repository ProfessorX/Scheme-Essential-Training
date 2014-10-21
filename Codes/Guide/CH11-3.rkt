;; for/list and for*/list
(for/list ([i (in-naturals 1)]
           [chapter '("Intro" "Details" "Conclusion")])
  (string-append (number->string i) ". " chapter))

(for/list ([i (in-naturals 1)]
           [chapter '("Intro" "Details" "Conclusion")]
           #:when (odd? i))
  chapter)

#|
This pruning behavior of #:when is more useful with for/list than for. Whereas a plain
when form normally suffices with for, a when expression form in a for/list would cause
the result list to contain #<void>s instead of omitting list elements.
|#

(for*/list ([book '("Guide" "Ref.")]
            [chapter '("Intro" "Details")])
  (string-append book " " chapter))
