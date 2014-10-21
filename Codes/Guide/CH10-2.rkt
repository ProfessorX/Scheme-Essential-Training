;; Prompts and Aborts
#|
When an exception is raised, control escapes out of an arbitrary deep evaluation context to
the point where the exception is caught—or all the way out if the exception is never caught

But if control escapes “all the way out,” why does the REPL keep going after an error is
printed? You might think that it’s because the REPL wraps every interaction in a with-
handlers form that catches all exceptions, but that’s not quite the reason.
|#

(+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (/ 1 0)))))))


(define (escape v)
  (abort-current-continuation
   (default-continuation-prompt-tag)
   (lambda () v)))
; test
; Please run in REPL, the Geiser and/or Smartparen have some
; trouble running this.
(+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (+ 1 (escape 0)))))))

(+1
 (call-with-continuation-prompt
  (lambda ()
    (+1 (+1 (+1 (+1 (+1 (+1 (escape 0))))))))
  (default-continuation-prompt-tag)))


