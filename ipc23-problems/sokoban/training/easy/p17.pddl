;; grid_size=8, boxes=1, out_folder=training/easy, instance_id=17, seed=46
;;
;;   #  #  #  #  #  #  #  #
;;   #  #  #  .  .  #  #  #
;;   #  #  .  #  .  .  #  #
;;   #  #  #  #  #  #  #  #
;;   #  # RG  +  +  +  +  #
;;   #  .  + 1+  +  +  +  #
;;   #  #  .  #  +  +  #  #
;;   #  #  #  #  #  #  #  #
;; 

(define (problem sokoban-17)
 (:domain sokoban)
 (:objects 
    loc_1_1 loc_1_2 loc_1_3 loc_1_4 loc_1_5 loc_1_6 loc_1_7 loc_1_8 loc_2_1 loc_2_2 loc_2_3 loc_2_4 loc_2_5 loc_2_6 loc_2_7 loc_2_8 loc_3_1 loc_3_2 loc_3_3 loc_3_4 loc_3_5 loc_3_6 loc_3_7 loc_3_8 loc_4_1 loc_4_2 loc_4_3 loc_4_4 loc_4_5 loc_4_6 loc_4_7 loc_4_8 loc_5_1 loc_5_2 loc_5_3 loc_5_4 loc_5_5 loc_5_6 loc_5_7 loc_5_8 loc_6_1 loc_6_2 loc_6_3 loc_6_4 loc_6_5 loc_6_6 loc_6_7 loc_6_8 loc_7_1 loc_7_2 loc_7_3 loc_7_4 loc_7_5 loc_7_6 loc_7_7 loc_7_8 loc_8_1 loc_8_2 loc_8_3 loc_8_4 loc_8_5 loc_8_6 loc_8_7 loc_8_8 - location
    box1 - box
    )
 (:init 

    (at-robot loc_5_3)
    (at box1 loc_6_4)
    (clear loc_5_5)
    (clear loc_7_3)
    (clear loc_3_5)
    (clear loc_6_6)
    (clear loc_7_6)
    (clear loc_5_4)
    (clear loc_6_5)
    (clear loc_5_7)
    (clear loc_6_2)
    (clear loc_5_3)
    (clear loc_7_5)
    (clear loc_2_5)
    (clear loc_5_6)
    (clear loc_6_7)
    (clear loc_3_3)
    (clear loc_3_6)
    (clear loc_2_4)
    (clear loc_6_3)
    (adjacent loc_2_4 loc_2_5 right)
    (adjacent loc_2_5 loc_3_5 down)
    (adjacent loc_2_5 loc_2_4 left)
    (adjacent loc_3_5 loc_2_5 up)
    (adjacent loc_3_5 loc_3_6 right)
    (adjacent loc_3_6 loc_3_5 left)
    (adjacent loc_5_3 loc_6_3 down)
    (adjacent loc_5_3 loc_5_4 right)
    (adjacent loc_5_4 loc_6_4 down)
    (adjacent loc_5_4 loc_5_3 left)
    (adjacent loc_5_4 loc_5_5 right)
    (adjacent loc_5_5 loc_6_5 down)
    (adjacent loc_5_5 loc_5_4 left)
    (adjacent loc_5_5 loc_5_6 right)
    (adjacent loc_5_6 loc_6_6 down)
    (adjacent loc_5_6 loc_5_5 left)
    (adjacent loc_5_6 loc_5_7 right)
    (adjacent loc_5_7 loc_6_7 down)
    (adjacent loc_5_7 loc_5_6 left)
    (adjacent loc_6_2 loc_6_3 right)
    (adjacent loc_6_3 loc_7_3 down)
    (adjacent loc_6_3 loc_6_2 left)
    (adjacent loc_6_3 loc_5_3 up)
    (adjacent loc_6_3 loc_6_4 right)
    (adjacent loc_6_4 loc_6_3 left)
    (adjacent loc_6_4 loc_5_4 up)
    (adjacent loc_6_4 loc_6_5 right)
    (adjacent loc_6_5 loc_7_5 down)
    (adjacent loc_6_5 loc_6_4 left)
    (adjacent loc_6_5 loc_5_5 up)
    (adjacent loc_6_5 loc_6_6 right)
    (adjacent loc_6_6 loc_7_6 down)
    (adjacent loc_6_6 loc_6_5 left)
    (adjacent loc_6_6 loc_5_6 up)
    (adjacent loc_6_6 loc_6_7 right)
    (adjacent loc_6_7 loc_6_6 left)
    (adjacent loc_6_7 loc_5_7 up)
    (adjacent loc_7_3 loc_6_3 up)
    (adjacent loc_7_5 loc_6_5 up)
    (adjacent loc_7_5 loc_7_6 right)
    (adjacent loc_7_6 loc_7_5 left)
    (adjacent loc_7_6 loc_6_6 up))
 (:goal  (and 
    (at box1 loc_5_3))))
