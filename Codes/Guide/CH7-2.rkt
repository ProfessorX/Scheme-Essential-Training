;; Simple Contracts on Functions
#|
A mathematical function has a domain and a range. The domain indicates the kind of values
that the function can accept as arguments, and the range indicates the kind of values that it
produces. The conventional notation for describing a function with its domain and range is
f : A -> B
where A is the domain of the function and B is the range.

Functions in a programming language have domains and ranges, too, and a contract can
ensure that a function receives only values in its domain and produces only values in its
range. A -> creates such a contract for a function. The forms after a -> specify contracts for
the domains and finally a contract for the range.
|#




; Here is a module that might represent a band account
#lang racket

(provide (contract-out
          [deposite (-> number? any)]
          [balance (-> number?)]))

(define amount 0)
(define (deposite a) (set! amount  (+ amount a)))
(define (balance amount))

; A -> by itself is not a contract it is a contract combinator, which combines other contracts
; to form a contract.

; Style of ->
(provide (contract-out
          [deposite (number? . -> . any)]))

; Using define/contract and ->
(define/contract (deposite amount)
  (-> number? any)
  ; implementation goes here
  ...)
#|
Note that this has two
potentially important impacts on the use of deposit:
1. Since the contract will always be checked on calls to deposit, even inside the module
in which it is defined, this may increase the number of times the contract is checked.
This could lead to a performance degradation. This is especially true if the function is
called repeatedly in loops or using recursion.
2. In some situations, a function may be written to accept a more lax set of inputs when
called by other code in the same module. For such use cases, the contract boundary
established by define/contract is too strict.
|#


; any and any/c
#|
The any/c contract is similar to any, in that it makes no demands on a value. Unlike any,
any/c indicates a single value, and it is suitable for use as an argument contract. Using
any/c as a range contract imposes a check that the function produces a single value. 

Use any/c as a result contract when it is particularly important to promise a single result
from a function. Use any when you want to promise as little as possible (and incur as little
checking as possible) for a function’s result.
|#

; They are DIFFERENT
(-> integer? any)
(-> integer? any/c) 

(define (f x)
  (values (+ x 1) (- x 1)))
; test
(f 998)


; Rolling your own contracts
#|
The deposit function adds the given number to the value of amount. While the function’s
contract prevents clients from applying it to non-numbers, the contract still allows them
to apply the function to complex numbers, negative numbers, or inexact numbers, none of
which sensibly represent amounts of money.
|#

#lang racket

(define (amount? a)
  (and (number? a) (integer? a) (exact? a) (>= a 0)))

(provide (contract-out
          ; an amount is a natural number of cents
          ; is the given number an amount?
          [deposite (-> amount? any)]
          [amount? (-> any/c boolean?)]
          [balance (-> amount?)]))

(define amount 0)
(define (deposite a) (set! amount (+ amount a)))
(define (balance) amount)

#|
Of course, it makes no sense to restrict a channel of communication to values that the client
doesn’t understand. Therefore the module also exports the amount? predicate itself, with a
contract saying that it accepts an arbitrary value and returns a boolean.
|#

; a little bit refactor
(provide (contract-out
          [deposite (-> natural-number/c any)]
          [balance (-> natural-number/c)]))

; Every function that accepts one argument can be treated as a predicate and thus used as
; a contract. For combining existing checks into a new one, however, contract combinators
; such as and/c and or/c are often useful. For example, here is yet another way to write the
; contracts above:
(define amount/c
  (and/c number? integer? exact? (or/c positive? zero?)))


#lang racket

(define (has-decimal? str)
  (define L (string-length str))
  (and (>= L 3)
       (char=? #\. (string-ref str (- L 3)))))

(provide (contract-out
          ; convert a random number to a string
          [format-number (-> number? string?)]
          ; convert an amount into a string with a decimal
          ; point, as in an amount of US currency
          [format-nat (-> natural-number/c
                          (and/c string? has-decimal?))]))


; A dummy strengthened version
#lang racket

(define (digit-char? x)
  (member x '(#\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9 #\0)))

(define (has-decimal? str)
  (define L (string-length str))
  (and (>= L 3)
       (char=? #\. (string-ref str (- L 3)))))

(define (is-decimal-string? str)
  (define L (string-length str))
  (and (has-decimal? str)
       (andmap digit-char?
               (string->list (substring str 0 (- L 3))))
       (andmap digit-char?
               (string->list (substring str (- L 2) L)))))

...

(provide (contract-out
          ...
          ; convert an amount (natural number) of cents
          ; into a dollar-based string
          [format-nat (-> natural-number/c
                          (and/c string? is-decimal-string?))]))

; Alternately, in this case, we could use a **regular expression** as a contract:
#lang racket

(provide
 (contract-out
  ...
  ; convert an amount (natural number) of cents
  ; into a dollar-based string
  [format-nat (-> natural-number/c
                  (and/c string? #rx"[0-9]*\\.[0-9][0-9]"))]))


; Contracts on Higher-Order Functions
#|
Function contracts are not just restricted to having simple predicates on their domains or
ranges. Any of the contract combinators discussed here, including function contracts them-
selves, can be used as contracts on the arguments and results of a function.
|#

(-> integer? (-> integer? integer?))
#|
Explanation:
is a contract that describes a curried function. It matches functions that accept one argument
and then return another function accepting a second argument before finally returning an
integer. If a server exports a function make-adder with this contract, and if make-adder
returns a value other than a function, then the server is to blame. If make-adder does return
a function, but the resulting function is applied to a value other than an integer, then the
client is to blame.
|#

(-> (-> integer? integer?) integer?)


; Contract Messages with "???"
(module bank-server racket
  (provide
   (contract-out
    [deposit (-> (lambda (x)
                   (and (number? x) (integer? x) (>= x 0)))
                 any)]))
  (define total 0)
  (define (deposit a) (set! total (+ a total))))
; test
(require 'bank-server)
(deposit -10)

#|
For this situation, Racket provides flat named contracts. The use of “contract” in this term
shows that contracts are first-class values. The “flat” means that the collection of data is a
subset of the built-in atomic classes of data; they are described by a predicate that consumes
all Racket values and produces a boolean. 
|#

(module improved-bank-server racket
  (define (amount? x) (and (number? x) (integer? x) (>= x 0)))
  (define amount (flat-named-contract 'amount amount?))
  
  (provide (contract-out [deposit (-> amount any)]))

  (define total 0)
  (define (deposit a) (set! total (+ a total))))


; Dissecting a contract error message

