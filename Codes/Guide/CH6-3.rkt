;; Module Paths
; A module path is a reference to a module, as used with require or as the initial-
; module-path in a module form. It can be any of several forms:

(quote id)

(module m racket
  (provide color)
  (define color "blue"))

(module n racket
  (require 'm)
  (printf "my favorite color is ~a\n" color))

(require 'n)  ; the above codes should be tested under REPL

rel-string
#|
A string module path is a relative path using Unix-style conventions: / is the
path separator, .. refers to the parent directory, and . refers to the same direc-
tory. The rel-string must not start or end with a path separator. If the path
has no suffix, ".rkt" is added automatically.
|#

id

(module m racket
  (require racket/date)

  (printf "Today is ~s\n"
          (date->string (seconds->date (current-seconds)))))
(require 'm)


(lib rel-string)
#|
Like an unquoted-identifier path, but expressed as a string instead of an identi-
fier. Also, the rel-string can end with a file suffix, in which case ".rkt" is
not automatically added.
|#

(module m (lib "racket")
  (require (lib "racket/date.rkt"))
  
  (printf "Today is ~s\n"
          (date->string (seconds->date (current-seconds)))))

(planet id)
#|
Accesses a third-party library that is distributed through the PLaneT server. The
library is downloaded the first time that it is needed, and then the local copy is
used afterward.
|#

(module m (lib "racket")
  ; Use "schematics"'s "random.plt" 1.0
  (require (planet schematics/random:1/random))
  (display (random-gaussian)))
; test
(require 'm)


(planet package-string)
#|
Like the symbol form of a planet, but using a string instead of an identifier.
Also, the package-string can end with a file suffix, in which case ".rkt" is
not added.
|#


(planet rel-string (user-string pkg-string vers ...))
vers = nat | (nat nat) | (= nat) | (+ nat) | (- nat)
#|
A more general form to access a library from the PLaneT server. In this general
form, a PLaneT reference starts like a lib reference with a relative path, but the
path is followed by information about the producer, package, and version of the
library. The specified package is downloaded and installed on demand.
|#

(module m (lib "racket")
  (require (planet "random.rkt" ("schematics" "random.plt" 1 0)))
  (display (random-gaussian)))
; test
(require 'm)


(file string)


(submod base element ...+)
base = module-path | "." | ".."
element = id | ".."

(module zoo racket
  (module monkey-house racket
    (provide monkey)
    (define monkey "Curious George")))

(require (submod 'zoo monkey-house))


(module zoo racket
  (module monkey-house racket
    (provide monkey)
    (define monkey "Curious George"))
  (module crocodile-house racket
    (require (submod ".." monkey-house))
    (provide dinner)
    (define dinner monkey)))
; test
(require (submod 'zoo crocodile-house))
dinner
