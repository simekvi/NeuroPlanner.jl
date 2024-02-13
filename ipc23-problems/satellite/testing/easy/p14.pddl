;; satellites=6, instruments=10, modes=2, directions=7, out_folder=testing/easy, instance_id=14, seed=1020

(define (problem satellite-14)
 (:domain satellite)
 (:objects 
    sat1 sat2 sat3 sat4 sat5 sat6 - satellite
    ins1 ins2 ins3 ins4 ins5 ins6 ins7 ins8 ins9 ins10 - instrument
    mod1 mod2 - mode
    dir1 dir2 dir3 dir4 dir5 dir6 dir7 - direction
    )
 (:init 
    (pointing sat1 dir1)
    (pointing sat2 dir1)
    (pointing sat3 dir4)
    (pointing sat4 dir7)
    (pointing sat5 dir4)
    (pointing sat6 dir5)
    (power_avail sat1)
    (power_avail sat2)
    (power_avail sat3)
    (power_avail sat4)
    (power_avail sat5)
    (power_avail sat6)
    (calibration_target ins1 dir2)
    (calibration_target ins2 dir3)
    (calibration_target ins3 dir7)
    (calibration_target ins4 dir2)
    (calibration_target ins5 dir5)
    (calibration_target ins6 dir3)
    (calibration_target ins7 dir3)
    (calibration_target ins8 dir4)
    (calibration_target ins9 dir5)
    (calibration_target ins10 dir5)
    (on_board ins1 sat5)
    (on_board ins2 sat2)
    (on_board ins3 sat1)
    (on_board ins4 sat4)
    (on_board ins5 sat6)
    (on_board ins6 sat3)
    (on_board ins7 sat2)
    (on_board ins8 sat1)
    (on_board ins9 sat5)
    (on_board ins10 sat6)
    (supports ins8 mod1)
    (supports ins6 mod1)
    (supports ins10 mod1)
    (supports ins3 mod1)
    (supports ins5 mod2)
    (supports ins6 mod2)
    (supports ins9 mod1)
    (supports ins1 mod1)
    (supports ins4 mod2)
    (supports ins1 mod2)
    (supports ins5 mod1)
    (supports ins9 mod2)
    (supports ins7 mod1)
    (supports ins4 mod1)
    (supports ins10 mod2)
    (supports ins2 mod1))
 (:goal  (and (pointing sat1 dir7)
   (pointing sat2 dir3)
   (pointing sat3 dir3)
   (pointing sat5 dir5)
   (have_image dir3 mod1)
   (have_image dir7 mod2)
   (have_image dir5 mod2)
   (have_image dir4 mod2)
   (have_image dir1 mod1)
   (have_image dir6 mod1)
   (have_image dir6 mod2))))
