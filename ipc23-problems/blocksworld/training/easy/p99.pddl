;; blocks=29, out_folder=training/easy, instance_id=99, seed=126

(define (problem blocksworld-99)
 (:domain blocksworld)
 (:objects b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 - object)
 (:init 
    (arm-empty)
    (clear b14)
    (on b14 b10)
    (on b10 b25)
    (on b25 b1)
    (on b1 b13)
    (on-table b13)
    (clear b27)
    (on b27 b7)
    (on b7 b4)
    (on b4 b18)
    (on b18 b3)
    (on b3 b9)
    (on b9 b17)
    (on b17 b11)
    (on b11 b12)
    (on b12 b28)
    (on-table b28)
    (clear b26)
    (on b26 b5)
    (on b5 b22)
    (on b22 b24)
    (on-table b24)
    (clear b23)
    (on b23 b16)
    (on b16 b6)
    (on b6 b21)
    (on b21 b8)
    (on b8 b15)
    (on-table b15)
    (clear b20)
    (on b20 b29)
    (on b29 b2)
    (on b2 b19)
    (on-table b19))
 (:goal  (and 
    (clear b29)
    (on b29 b7)
    (on b7 b10)
    (on b10 b25)
    (on b25 b26)
    (on b26 b23)
    (on b23 b4)
    (on b4 b22)
    (on b22 b20)
    (on b20 b21)
    (on b21 b18)
    (on b18 b13)
    (on b13 b3)
    (on b3 b27)
    (on b27 b8)
    (on b8 b5)
    (on-table b5)
    (clear b28)
    (on b28 b1)
    (on b1 b12)
    (on b12 b2)
    (on b2 b9)
    (on b9 b17)
    (on b17 b24)
    (on b24 b14)
    (on b14 b15)
    (on b15 b11)
    (on b11 b19)
    (on b19 b16)
    (on b16 b6)
    (on-table b6))))