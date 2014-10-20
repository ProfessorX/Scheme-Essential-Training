;; Abstract contract using #:exists and #:∃
#|
The contract system provides existential contracts that can protect abstractions, ensuring
that clients of your module cannot depend on the precise representation choices you make
for your data structures.
|#

#lang racket

; As an example, consider this (simple) implementation of a queue datastructure
(define empty '())
(define (enq top queue) (append queue (list top)))
(define (next queue) (car queue))
(define (deq queue) (cdr queue))
(define (empty? queue) (null? queue))

(provide
 (contract-out
  [empty (listof integer?)]
  [enq (-> integer? (listof integer?) (listof integer?))]
  [next (-> (listof integer?) integer?)]
  [deq (-> (listof integer?) (listof integer?))]
  [empty? (-> (listof )) boolean?]))


; To ensure that the queue representation is abstract, we can use #:∃ in the contract-out
; expression, like this:
(provide
 (contract-out
  #:exists queue
  [empty (listof integer?)]
  [enq (-> integer? (listof integer?) (listof integer?))]
  [next (-> (listof integer?) integer?)]
  [deq (-> (listof integer?) (listof integer?))]
  [empty? (-> (listof )) boolean?]))


