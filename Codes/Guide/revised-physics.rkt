#lang racket
(module+ test
  (require rackunit)
  (define \epsilon 1e-10))

(provide drop
         to-energy)

(define (drop t)
  (* 1/2 9.8 t t))

(module+ test
  (check-= (drop 0) 0 \epsilon)
  (check-= (drop 10) 490 \epsilon))

(define (to-energy m)
  (* m (expt 299792456.0 2)))

(module* test #f
  (require rackunit)
  (define \epsilon 1e-10)
  (check-= (drop 0) 0 \epsilon)
  (check-= (drop 10) 490 \epsilon)
  (check-= (to-energy 0) 0 \epsilon)
  (check-= (to-energy 1) 9e+16 1e+15))
