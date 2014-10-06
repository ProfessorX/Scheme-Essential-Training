#lang racket

(define max-mag
  (λ (num . nums)
     (apply max-mag (map magnitude (cons num nums)))))  ; Yeah something is wrong with this, right?