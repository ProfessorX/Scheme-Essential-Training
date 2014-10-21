;; Multiple-Values Sequences
#|
In the same way that a function or expression can produce multiple values, individual itera-
tions of a sequence can produce multiple elements. For example, a hash table as a sequence
generates two values for each iteration: a key and a value.
|#
(for 
    ([(k v) #hash(("apple" . 1) ("banana" . 3))])
  (printf "~a count: ~a\n" k v))

(for*/list ([(k v) #hash(("apple" . 1) ("banana" . 3))]
            [(i) (in-range v)])
  k)
