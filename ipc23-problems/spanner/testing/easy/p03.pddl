;; spanners=1, nuts=1, locations=4, out_folder=testing/easy, instance_id=3, seed=1009

(define (problem spanner-03)
 (:domain spanner)
 (:objects 
    bob - man
    spanner1 - spanner
    nut1 - nut
    shed location1 location2 location3 location4 gate - location
 )
 (:init 
    (at bob shed)
    (at spanner1 location2)
    (usable spanner1)
    (at nut1 gate)
    (loose nut1)
    (link shed location1)
    (link location4 gate)
    (link location1 location2)
     (link location2 location3)
     (link location3 location4)
 )
 (:goal  (and (tightened nut1))))
