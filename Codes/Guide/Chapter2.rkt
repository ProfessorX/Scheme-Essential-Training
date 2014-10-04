;;; Racket Essentials

;; Simple values
; numbers
1 
3.14
1/2
1+2i
6.02e+23
999999999999999999999

; booleans
#t
#f

; strings
"Hello, World!"
"Benjamin \"Bugsy\" Siegel"
"λx: (ua.a->a).xx"

1.000
"Bugs \u0022Figaro\u0022 Bunny"

;; Simple definitions
; a definition of the form --> ( define <id> <expr> ) 
; ( define ( <id> <id>* ) expr+ )
(define pie 3)  ; defines pie to be 3
(define (piece str)
  (substring str 0 pie))

; test
pie
(piece "key lime")
piece
substring

(define (bake flavor)
  (printf "pre-heating oven...\n")
  (string-append flavor " pie"))

; test
(bake apple)  ; not working
(bake "apple")

(define (nobake flavor)
  string-append flavor "jello")
; test
(nobake "green")

;; identifiers
; ( ) [ ] { } " " , ' ` '; # | \

; examples
+
Hfuhruhurr
integer?
pass/fail
john-jacob-jingleheimer-schemidt
a-b-c+1-2-3

;; function calls
; ( <id> <expr>* )

(string-append "repo" "twine" "yarn")  ; append strings
(substring "corudyoiasd" 0 4)  ; extract a substring
(string-length "shoelace") ; get a string's length
(string? "Life is fucking awesome in the United Arab Emirates!")


 
