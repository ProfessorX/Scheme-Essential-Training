#lang racket

(require racket/draw)

(define (plot-line dc x1 y1 x2 y2 cap)
    (send dc set-pen
          (send the-pen-list find-or-create-pen
                "black" 40 'solid cap))
    (send dc draw-line x1 y1 x2 y2)
    (send dc set-brush "red" 'solid)
    (send dc set-pen "black" 1 'transparent)
    (send dc draw-ellipse (- x1 4) (- y1 4) 8 8)
    (send dc draw-ellipse (- x2 4) (- y2 4) 8 8))

(dc
   (λ (dc dx dy)
     (define old-pen (send dc get-pen))
     (define old-brush (send dc get-brush))
  
     (plot-line dc 20 30 80 90 'round)
     (plot-line dc 100 30 160 90 'butt)
     (plot-line dc 180 30 240 90 'projecting)
  
     (send dc set-pen old-pen)
     (send dc set-brush old-brush))
   270 120)