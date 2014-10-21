;; Sequence Constructors

(for ([i 3])
  (display i))

(for ([i (in-range 3)])
  (display i))

(for ([i (in-range 1 4)])
  (display i))

(for ([i (in-range 1 4 2)])
  (display i))

(for ([i (in-range 4 1 -1)])
  (display i))


(for ([i (in-range 1 4 1/2)])
  (printf " ~a " i))

#|
The in-naturals function is similar, except that the starting number must be an exact non-
negative integer (which defaults to 0), the step is always 1, and there is no upper limit. A
for loop using just in-naturals will never terminate unless a body expression raises an
exception or otherwise escapes.
|#

(for ([i (in-naturals)])
  (if (= i 10)
      (error "TOO MUCH! Eat my dic tator!")
      (display i)))

(for ([i (stop-before "abc def"
                      char-whitespace?)])
  (display i))

#|
Sequence constructors like in-list, in-vector and in-string simply make explicit the
use of a list, vector, or string as a sequence. Along with in-range, these constructors raise
an exception when given the wrong kind of value, and since they otherwise avoid a run-time
dispatch to determine the sequence type, they enable more efficient code generation; see
§11.10 “Iteration Performance” for more information.
|#


(for ([i (in-string "abcdefg")])
  (display i))

(for ([i (in-string '(1 2 3))])
  (display i))


