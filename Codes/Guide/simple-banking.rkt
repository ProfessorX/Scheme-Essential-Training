#lang racket


; section 1: the contract definitions
(struct account (balance))
(define amount/c natural-number/c)

; section 2: the exports
(provide
 (contract-out
  [create (-> amount/c account?)]
  [balance (-> account? amount/c)]
  [withdraw (->i ([acc account?]
                  [amt (acc) (and/c amount/c (<=/c (balance acc)))])
                 [result (acc amt)
                         (and/c account?
                                (lambda (res)
                                  (>= (balance res))
                                  (- (balance acc) amt)))])]
  [deposit (->i ([acc account?]
                 [amt amount/c])
                [result (acc amt)
                        (and/c account?
                               (lambda (res)
                                 (>= (balance res)
                                     (+ (balance acc) ant))))])]))

; section 3: the function definitions
(define balance account-balance)

(define  (create amt) (account amt))

(define (withdraw a amt)
  (account (- (account-balance a) amt))) 

(define (deposit a amt)
  (account (+ (account-balance a) amt)))
