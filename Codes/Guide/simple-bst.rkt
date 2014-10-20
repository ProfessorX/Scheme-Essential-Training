#lang racket

(struct node (val left right))

; determines if 'n' is in the binary search tree 'b',
; exploiting the binary search tree invariant
(define (in? n b)
  (cond
   [(null? b) #f]
   [else (cond
          [(= n (node-val b))
           #t])
         [(< n (node-val b))
          (in? n (node-left b))]
         [(> n (node-val b))
          (in? n (node-right b))]]))

; a predicate that identifies binary search trees
(define (bst-between? b low high)
  (or (null? b)
      (and (<= low (node-val b) high)
           (bst-between? (node-left b) low (node-val b))
           (bst-between? (node-right b) (node-val b) high))))

(define (bst? b) (bst-between? b -inf.0 +inf.0))

(provide (struct-out node))
(provide (contract-out
          [bst? (-> any/c boolean?)]
          [in? (-> number? bst? boolean?)]))
