;; Default Ports
#|
For most simple I/O functions, the target port is an optional argument, and the default is
the current input port or current output port. Furthermore, error messages are written to the
current error port, which is an output port. The current-input-port, current-output-
port, and current-error-port functions return the corresponding current ports.
|#
 
(display "Life is fucking awesome in the United Arab Emirates!")

(display "Life is fucking awesome in the United Arab Emirates!" 
         (current-output-port))  ; the same

(define (swing-hammer)
  (display "Ouch!" (current-error-port)))

(swing-hammer)

; The current-port functions are actually parameters, which means that their values can be set
; with parameterize.
(let ([s (open-output-string)])
  (parameterize ([current-error-port s])
    (swing-hammer)
    (swing-hammer)
    (swing-hammer))
  (get-output-string s))


