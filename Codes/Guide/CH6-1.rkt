;;; Modules
; Modules let you organize Racket code into multiple files and reusable libraries.


;; Module Basics

; Each Racket module typically resides in its own file.

#|
The relative reference "cake.rkt" in the import (require "cake.rkt") works if the
"cake.rkt" and "random-cake.rkt" modules are in the same directory. Unix-style rela-
tive paths are used for relative module references on all platforms, much like relative URLs
in HTML pages.
|#

; Organizing Modules

#lang racket
(require "db/lookup.rkt" "machine/control.rkt")

; for db/lookup.rkt
#lang racket
(require "barcode.rkt" "makers.rkt")

; for machine/control.rkt
#lang racket
(require "sensors.rkt" "actuators.rkt")
