;; Structure Comparisons
; A generic equal? comparison automatically recurs on the fields of a transparent structure
; type, but equal? defaults to mere instance identity for opaque structure types:

(struct glass (width height) #:transparent)
; test
(equal? (glass 1 2) (glass 1 2))

(struct lead (width height))

(define slab (lead 1 2))
(equal? slab slab)
(equal? slab (lead 1 2))

; To support instances comparisons via equal? without making the structure type transparent,
; you can use the #:methods keyword, gen:equal+hash, and implement three methods:
(struct lead (width height)
        #:methods
        gen:equal+hash
        [(define (equal-proc a b equal?-recur)
           ; compare a and b
           (and (equal?-recur (lead-width a) (lead-width b))
                (equal?-recur (lead-height a) (lead-height b))))
         (define (hash-proc a hash-recur)
           ; compute primary hash code of a
           (+ (hash-recur (lead-width a))
              (* 3 (hash-recur (lead-height a)))))
         (define (hash2-proc a hash2-recur)
           ; compute secondary hash code of a
           (+ (hash2-recur (lead-width a))
              (hash2-recur (lead-height a))))])

(equal? (lead 1 2) (lead 1 2))

(define h (make-hash))
(hash-set! h (lead 1 2) 3)
(hash-ref h (lead 1 2))
(hash-ref h (lead 2 2))

