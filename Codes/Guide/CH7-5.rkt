;; Contracts on Structures
#|
Modules deal with structures in two ways. First they export struct definitions, i.e., the
ability to create structs of a certain kind, to access their fields, to modify them, and to distin-
guish structs of this kind against every other kind of value in the world. Second, on occasion
a module exports a specific struct and wishes to promise that its fields contain values of a
certain kind. This section explains how to protect structs with contracts for both uses.
|#


; Guarantee for a Specific Value
#lang racket
(require lang/posn)

(define origin (make-posn 0 0))

(provide (contract-out
          [origin (struct/c posn zero? zero?)]))

; Guarantee for All Values
#lang racket
(struct posn (x y))

(provide (contract-out
          [struct posn ((x number?) (y number?))]
          [p-okay posn?]
          [p-sick posn?]))

(define p-okay (posn 10 20))
(define p-sick (posn 'a 'b))
#|
This module exports the entire structure definition: posn, posn?, posn-x, posn-y, set-
posn-x!, and set-posn-y!. Each function enforces or promises that the two fields of a
posn structure are numbers — when the values flow across the module boundary. Thus, if a
client calls posn on 10 and 'a, the contract system signals a contract violation.
|#

; a single change
(provide
 (contract-out
  ...
  [p-sick (struct/c posn number? number?)]))


; Checking Properties of Data Structures

