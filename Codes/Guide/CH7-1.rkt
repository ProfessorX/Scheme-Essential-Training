;;; Contracts
; This chapter provides a gentle introduction to Racket’s contract system.

;; Contracts and Boundaries

#|
Like a contract between two business partners, a software contract is an agreement between
two parties. The agreement specifies obligations and guarantees for each “product” (or
value) that is handed from one party to the other.

A contract thus establishes a boundary between the two parties. Whenever a value crosses
this boundary, the contract monitoring system performs contract checks, making sure the
partners abide by the established contract.

In this spirit, Racket encourages contracts mainly at module boundaries. Specifically,
programmers may attach contracts to provide clauses and thus impose constraints and
promises on the use of exported values. For example, the export specification

|#

#lang racket

(provide (contract-out [amount positive?]))

(define amount ...)

; promises to all clients of the above module that the value of amount will always be a positive
; number. The contract system monitors the module’s obligation carefully. Every time a client
; refers to amount, the monitor checks that the value of amount is indeed a positive number.

#lang racket/base
(require racket/contract)  ; now we can write "CONTRACTS"

(provide (contract-out [amount positive?]))

(define amount ...)

; Contract Violations
#lang racket

(provide (contract-out [amount positive?]))

(define amount 0)

; An even bigger mistake
#lang racket

(provide (contract-out [amount positive?]))

(define amount 'amount)

; So we should apply contracts like this
(provide (contract-out [amount (and/c number? positive?)]))


; Experimenting with Contracts and Modules
#|
All of the contracts and modules in this chapter (excluding those just following) are writ-
ten using the standard #lang syntax for describing modules. Since modules serve as the
boundary between parties in a contract, examples involve multiple modules.
|#

; Try the example earlier in this section like this
#lang racket

(module+ server
  (provide (contract-out [amount (and/c number? positive?)]))
  (define amount 150))

(module+ main
  (require (submod ".." server))
  (+ amount 10))


; Experimenting with Nested Contract Boundaries
#lang racket

(define/contract amount
  (and/c number? positive?)
  150)

(+ amount 10)

#|
In this example, the define/contract form establishes a contract boundary between the
definition of amount and its surrounding context. In other words, the two parties here are
the definition and the module that contains it.

Forms that create these nested contract boundaries can sometimes be subtle to use because
they may have unexpected performance implications or blame a party that may seem un-
intuitive. These subtleties are explained in §7.2.2 “Using define/contract and ->” and
§7.8.2 “Contract boundaries and define/contract”.
|#

