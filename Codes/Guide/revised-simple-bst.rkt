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


; bst-between : number number -> contract
; builds a contract for binary search trees
; whose values are between low and high
(define (bst-between/c low high)
  (or/c null?
        (struct/dc node 
                   [val (between/c low high)]
                   [left (val) #:lazy (bst-between/c low val)]
                   [right (val) #:lazy (bst-between/c val high)])))

(define bst/c (bst-between/c -inf.0 +inf.0))

(provide (struct-out node))
(provide (contract-out
          [bst/ contract?]
          [in? (number? bst/c . -> . boolean?)]))


#|
Although this contract improves the performance of in?, restoring it to the logarithmic be-
havior that the contract-less version had, it is still imposes a fairly large constant overhead.
So, the contract library also provides define-opt/c that brings down that constant factor
by optimizing its body. Its shape is just like the define above. It expects its body to be a
contract and then optimizes that contract.
|#

(define-opt/c (bst-between/c low high)
  (or/c null?
        (struct/dc node 
                   [value-blame (between/c low high)]
                   [left (val) #:lazy (bst-between/c low val)]
                   [right (val) #:lazy (bst-between/c val high)])))
