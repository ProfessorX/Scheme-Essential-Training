;; Exports: provide
; By default, all of a module’s definitions are private to the module. The provide form
; specifies definitions to be made available where the module is required.

(provide provide-spec ...)

#|
A provide form can only appear at module level (i.e., in the immediate body of a module).
Specifying multiple provide-spec s in a single provide is exactly the same as using mul-
tiple provides each with a single provide-spec .
Each identifier can be exported at most once from a module across all provides within
the module. More precisely, the external name for each export must be distinct; the same
internal binding can be exported multiple times with different external names.
|#


identifier
; In its simplest form, a provide-spec indicates a binding within
; its module to be exported. The binding can be from either a local
; definition, or from an import.


(rename-out [orig-id export-id] ...)

(struct-out struct-id)

(all-defined-out)

(all-from-out module-path)
; The all-from-out shorthand exports all bindings in the module
; that were imported using a require-spec that is based on module-
; path .

(except-out provide-spec id ...)

(prefix-out prefix-id provide-spec)
