;; Imports: require
; The require form imports from another module. A require form can appear within a
; module, in which case it introduces bindings from the specified module into importing mod-
; ule. A require form can also appear at the top level, in which case it both imports bindings
; and instantiates the specified module; that is, it evaluates the body definitions and expres-
; sions of the specified module, if they have not been evaluated already.


(require require-spec ...)
; Specifying multiple require-spec s in a single require is essentially the same as using
;multiple requires, each with a single require-spec .

module-path

; You'd better test these codes under REPL
(module m racket
  (provide color)
  (define color "blue"))

(module n racket
  (provide size)
  (define size 17))
; test
(require 'm 'n)

; (only-in require-spec id-maybe-renamed ...)
; id-maybe-renamed = id | [orig-id bind-id]
#|
An only-in form limits the set of bindings that would be intro-
duced by a base require-spec . Also, only-in optionally renames
each binding that is preserved: in a [orig-id bind-id ] form, the
orig-id refers to a binding implied by require-spec , and bind-
id is the name that will be bound in the importing context instead of
orig-id .
|#

(module m (lib "racket")
  (provide tastes-great?
           less-filling?)
  (define tastes-great? #t)
  (define less-filling? #t))

(require (only-in 'm tastes-great?))
; test
tastes-great?
less-filling?
(require (only-in 'm [less-filling? lite?]))
lite?


(except-in require-spec id ...)
; This form is the complement of only-in: it excludes specific bind-
; ings from the set specified by require-spec .

(rename-in require-spec [orig-id bind-id] ...)

(prefix-in prefix-id require-spec)

(require (prefix-in m: (except-in 'm ghost)))
(require (except-in (prefix-in m: 'm) m:ghost))


































; Life is a bitch. Fuck it or leave it, choose ONE.
; Oh yes and one more thing, Life is fucking awesome in the United Arab Emirates.
