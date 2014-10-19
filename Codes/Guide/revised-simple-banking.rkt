#lang racket


                                        ; section 1: the contract definitions
(struct account (balance))
(define amount/c natural-number/c)

(define msg> "account a with balance larger than ~a expected")
(define msg< "account a with balance less than ~a expected")

(define (mk-account-contract acc amt op msg)
  (define balance0 (balance acc))
  (define (crt a)
    (and (account? a) (op balance0 (balance a))))
  (flat-named-contract (format msg balance0) ctr))

                                        ; section 2: the exports
(provide
 (contract-out
  [create (-> amount/c account?)]
  [balance (-> account? amount/c)]
  [withdraw (->i ([acc account?]
                  [amt (acc) (and/c amount/c (<=/c (balance acc)))])
                 [result (acc amt)
                         (mk-account-contract acc amt >= msg>)])]
  [deposit (->i ([acc account?]
                 [amt amount/c])
                [result (acc amt)
                        (mk-account-contract acc amt <= msg<)])]))

; section 3: the function definitions
(define balance account-balance)

(define  (create amt) (account amt))

(define (withdraw a amt)
  (account (- (account-balance a) amt))) 

(define (deposit a amt)
  (account (+ (account-balance a) amt))) 
