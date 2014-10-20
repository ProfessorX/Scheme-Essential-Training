;;; Input and Output

#|
A Racket port represents a source or sink of data, such as a file, a terminal, a TCP connection,
or an in-memory string. Ports provide sequential access in which data can be read or written
a piece of a time, without requiring the data to be consumed or produced all at once. More
specifically, an input port represents a source from which a program can read data, and an
output port represents a sink to which a program can write data.
|#

;; Varieties of Ports

; Files

(define out (open-output-file "data"))

(display "helllo" out)

(close-output-port out)

(define in (open-input-file "data"))

(read-line in)

(close-input-port in)

; If a file exists already, then open-output-file raises an exception by default. Sup-
; ply an option like #:exists 'truncate or #:exists 'update to re-write or up-
; date the file:

(define out (open-output-file "data" #:exists 'truncate))

(display "howdy" out)

(close-output-port out)

#|
Instead of having to match open-input-file and open-output-file calls, most
Racket programmers will instead use call-with-output-file, which takes a func-
tion to call with the output port; when the function returns, the port is closed.
|#

(call-with-output-file "data"
  #:exists 'truncate
  (lambda (out)
    (display "Hello" out)))

(call-with-input-file "data"
  (lambda (in)
    (read-line in)))


; Strings
(define p (open-output-string))

(display "Hello" p)

(get-output-string p)

(read-line (open-input-string "Goodbye\nFarewell"))

; TCP Connections
(define server (tcp-listen 12345))

(define-values (c-in c-out) (tcp-connect "localhost" 12345))

(define-values (s-in s-out) (tcp-accept server))

(display "Hello\n" c-out)

(close-output-port c-out)

(read-line s-in)

(read-line s-in)


; Process Pipes
#|
The subprocess function runs a new process at the OS level and re-
turns ports that correspond to the subprocess’s stdin, stdout, and stderr. (The first three
arguments can be certain kinds of existing ports to connect directly to the subprocess,
instead of creating new ports.)
|#

(define-values (p stdout stdin stderr)
  (subprocess #f #f #f "/usr/bin/wc" "-w"))

(display "a b c\n" stdin)

(close-output-port stdin)

(read-line stdout)

(close-input-port stdout)

(close-input-port stderr)

; Internal Pipes
#|
The make-pipe function returns two ports that are ends of a pipe.
This kind of pipe is internal to Racket, and not related to OS-level pipes for commu-
nicating between different processes.
|#
(define-values (in out) (make-pipe))

(display "garbage\nLife is\nA bitch" out)

(close-output-port out)

(read-line in)





