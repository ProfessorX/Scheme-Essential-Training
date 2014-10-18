;;; How I met your mother----IEEE Xtreme Series



; If possible, we had better convert all those lists of NUMBERS into lists
; of NUMBER STRINGS using (apply _ _) aka list comprehension
(define (find-lucky lottery lucky)
  (cond
   [(null? lottery) '()]    
   [(null? lucky) '()]
   [(substring-matching? (car lottery) (car lucky))
    (cons (car lottery) (find-lucky (cdr lottery) lucky))]
   [else (substring-matching? (car lottery) (cdr lucky))]))

(define substring-matching? lottery-number lucky-number
  (lambda ([low 0] [high (string-length (number->string lottery-number))])
    (cond
     [(equal? (substring (number->string lottery-number) low high)
              (number->string lucky-number))
      #t]
     [else (substring-matching? lottery-number lucky-number (add1 low) (add1 high))])))

; Well, I am not that familiar with Racket syntax for now, that's the general idea
; for that.


#|
  (cond
  [(equal? (substring (number->string lottery-number) low high)
  (number->string lucky-number))
  #t]
  [else (substring-matching? lottery-number lucky-number (add1 low) (add1 high))])
|#)
