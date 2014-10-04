;; That will work, because racket is willing to imitate a traditional Lisp environment, but we
strongly recommend against using load or writing programs outside of a module. 

(define (extract str)
        (substring str 4 7))
