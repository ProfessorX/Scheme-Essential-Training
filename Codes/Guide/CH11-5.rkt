;; for/and and for/or
(for/and ([chapter '("Intro" "Details" "Conclusion")])
  (equal? chapter "Intro"))


(for/or ([chapter '("Intro" "Details" "Conclusion")])
  (equal? chapter "Intro"))

