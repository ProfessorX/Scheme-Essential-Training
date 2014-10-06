;;; Expressions and Definitions
;; Notation


#|
This chapter (and the rest of the documentation) uses a slightly different notation than the
character-based grammars of the §2 “Racket Essentials” chapter. The grammar for a use of
a syntactic form something is shown like this:
|#
(something [id ...+] an-expr ...)

#|
The italicized meta-variables in this specification, such as id and an-expr , use the syntax
of Racket identifiers, so an-expr is one meta-variable. A naming convention implicitly
defines the meaning of many meta-variables:
* A meta-variable that ends in id stands for an identifier, such as x or my-favorite-
martian.
* A meta-identifier that ends in keyword stands for a keyword, such as #:tag.
* A meta-identifier that ends with expr stands for any sub-form, and it will be parsed
as an expression.
* A meta-identifier that ends with body stands for any sub-form; it will be parsed as
either a local definition or an expression. A body can parse as a definition only if it
is not preceded by any expression, and the last body must be an expression.

Square brackets in the grammar indicate a parenthesized sequence of forms, where square
brackets are normally used (by convention). That is, square brackets do not mean optional
parts of the syntactic form.

A ... indicates zero or more repetitions of the preceding form, and ...+ indicates one
or more repetitions of the preceding datum. Otherwise, non-italicized identifiers stand for
themselves.
|#

; examples
(something [x])
(something [x] (+ 1 2))
(something [x my-favorite-martian x] (+ 1 2) #f)

; (something-else [thing ...+] an-expr ...) 
; thing = thing-id | thing-keyword
