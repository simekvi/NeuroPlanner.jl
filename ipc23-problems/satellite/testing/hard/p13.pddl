;; satellites=70, instruments=110, modes=7, directions=64, out_folder=testing/hard, instance_id=13, seed=1019

(define (problem satellite-13)
 (:domain satellite)
 (:objects 
    sat1 sat2 sat3 sat4 sat5 sat6 sat7 sat8 sat9 sat10 sat11 sat12 sat13 sat14 sat15 sat16 sat17 sat18 sat19 sat20 sat21 sat22 sat23 sat24 sat25 sat26 sat27 sat28 sat29 sat30 sat31 sat32 sat33 sat34 sat35 sat36 sat37 sat38 sat39 sat40 sat41 sat42 sat43 sat44 sat45 sat46 sat47 sat48 sat49 sat50 sat51 sat52 sat53 sat54 sat55 sat56 sat57 sat58 sat59 sat60 sat61 sat62 sat63 sat64 sat65 sat66 sat67 sat68 sat69 sat70 - satellite
    ins1 ins2 ins3 ins4 ins5 ins6 ins7 ins8 ins9 ins10 ins11 ins12 ins13 ins14 ins15 ins16 ins17 ins18 ins19 ins20 ins21 ins22 ins23 ins24 ins25 ins26 ins27 ins28 ins29 ins30 ins31 ins32 ins33 ins34 ins35 ins36 ins37 ins38 ins39 ins40 ins41 ins42 ins43 ins44 ins45 ins46 ins47 ins48 ins49 ins50 ins51 ins52 ins53 ins54 ins55 ins56 ins57 ins58 ins59 ins60 ins61 ins62 ins63 ins64 ins65 ins66 ins67 ins68 ins69 ins70 ins71 ins72 ins73 ins74 ins75 ins76 ins77 ins78 ins79 ins80 ins81 ins82 ins83 ins84 ins85 ins86 ins87 ins88 ins89 ins90 ins91 ins92 ins93 ins94 ins95 ins96 ins97 ins98 ins99 ins100 ins101 ins102 ins103 ins104 ins105 ins106 ins107 ins108 ins109 ins110 - instrument
    mod1 mod2 mod3 mod4 mod5 mod6 mod7 - mode
    dir1 dir2 dir3 dir4 dir5 dir6 dir7 dir8 dir9 dir10 dir11 dir12 dir13 dir14 dir15 dir16 dir17 dir18 dir19 dir20 dir21 dir22 dir23 dir24 dir25 dir26 dir27 dir28 dir29 dir30 dir31 dir32 dir33 dir34 dir35 dir36 dir37 dir38 dir39 dir40 dir41 dir42 dir43 dir44 dir45 dir46 dir47 dir48 dir49 dir50 dir51 dir52 dir53 dir54 dir55 dir56 dir57 dir58 dir59 dir60 dir61 dir62 dir63 dir64 - direction
    )
 (:init 
    (pointing sat1 dir5)
    (pointing sat2 dir43)
    (pointing sat3 dir28)
    (pointing sat4 dir13)
    (pointing sat5 dir31)
    (pointing sat6 dir58)
    (pointing sat7 dir30)
    (pointing sat8 dir38)
    (pointing sat9 dir49)
    (pointing sat10 dir50)
    (pointing sat11 dir37)
    (pointing sat12 dir34)
    (pointing sat13 dir29)
    (pointing sat14 dir34)
    (pointing sat15 dir14)
    (pointing sat16 dir45)
    (pointing sat17 dir53)
    (pointing sat18 dir7)
    (pointing sat19 dir24)
    (pointing sat20 dir57)
    (pointing sat21 dir37)
    (pointing sat22 dir61)
    (pointing sat23 dir61)
    (pointing sat24 dir6)
    (pointing sat25 dir16)
    (pointing sat26 dir64)
    (pointing sat27 dir21)
    (pointing sat28 dir25)
    (pointing sat29 dir52)
    (pointing sat30 dir53)
    (pointing sat31 dir64)
    (pointing sat32 dir22)
    (pointing sat33 dir56)
    (pointing sat34 dir7)
    (pointing sat35 dir14)
    (pointing sat36 dir38)
    (pointing sat37 dir14)
    (pointing sat38 dir58)
    (pointing sat39 dir49)
    (pointing sat40 dir14)
    (pointing sat41 dir38)
    (pointing sat42 dir23)
    (pointing sat43 dir54)
    (pointing sat44 dir27)
    (pointing sat45 dir37)
    (pointing sat46 dir60)
    (pointing sat47 dir27)
    (pointing sat48 dir57)
    (pointing sat49 dir26)
    (pointing sat50 dir25)
    (pointing sat51 dir29)
    (pointing sat52 dir16)
    (pointing sat53 dir45)
    (pointing sat54 dir3)
    (pointing sat55 dir20)
    (pointing sat56 dir16)
    (pointing sat57 dir62)
    (pointing sat58 dir7)
    (pointing sat59 dir11)
    (pointing sat60 dir56)
    (pointing sat61 dir5)
    (pointing sat62 dir6)
    (pointing sat63 dir50)
    (pointing sat64 dir54)
    (pointing sat65 dir34)
    (pointing sat66 dir45)
    (pointing sat67 dir38)
    (pointing sat68 dir57)
    (pointing sat69 dir17)
    (pointing sat70 dir62)
    (power_avail sat1)
    (power_avail sat2)
    (power_avail sat3)
    (power_avail sat4)
    (power_avail sat5)
    (power_avail sat6)
    (power_avail sat7)
    (power_avail sat8)
    (power_avail sat9)
    (power_avail sat10)
    (power_avail sat11)
    (power_avail sat12)
    (power_avail sat13)
    (power_avail sat14)
    (power_avail sat15)
    (power_avail sat16)
    (power_avail sat17)
    (power_avail sat18)
    (power_avail sat19)
    (power_avail sat20)
    (power_avail sat21)
    (power_avail sat22)
    (power_avail sat23)
    (power_avail sat24)
    (power_avail sat25)
    (power_avail sat26)
    (power_avail sat27)
    (power_avail sat28)
    (power_avail sat29)
    (power_avail sat30)
    (power_avail sat31)
    (power_avail sat32)
    (power_avail sat33)
    (power_avail sat34)
    (power_avail sat35)
    (power_avail sat36)
    (power_avail sat37)
    (power_avail sat38)
    (power_avail sat39)
    (power_avail sat40)
    (power_avail sat41)
    (power_avail sat42)
    (power_avail sat43)
    (power_avail sat44)
    (power_avail sat45)
    (power_avail sat46)
    (power_avail sat47)
    (power_avail sat48)
    (power_avail sat49)
    (power_avail sat50)
    (power_avail sat51)
    (power_avail sat52)
    (power_avail sat53)
    (power_avail sat54)
    (power_avail sat55)
    (power_avail sat56)
    (power_avail sat57)
    (power_avail sat58)
    (power_avail sat59)
    (power_avail sat60)
    (power_avail sat61)
    (power_avail sat62)
    (power_avail sat63)
    (power_avail sat64)
    (power_avail sat65)
    (power_avail sat66)
    (power_avail sat67)
    (power_avail sat68)
    (power_avail sat69)
    (power_avail sat70)
    (calibration_target ins1 dir4)
    (calibration_target ins2 dir58)
    (calibration_target ins3 dir55)
    (calibration_target ins4 dir60)
    (calibration_target ins5 dir32)
    (calibration_target ins6 dir33)
    (calibration_target ins7 dir43)
    (calibration_target ins8 dir63)
    (calibration_target ins9 dir3)
    (calibration_target ins10 dir1)
    (calibration_target ins11 dir34)
    (calibration_target ins12 dir30)
    (calibration_target ins13 dir61)
    (calibration_target ins14 dir53)
    (calibration_target ins15 dir44)
    (calibration_target ins16 dir36)
    (calibration_target ins17 dir25)
    (calibration_target ins18 dir50)
    (calibration_target ins19 dir7)
    (calibration_target ins20 dir64)
    (calibration_target ins21 dir30)
    (calibration_target ins22 dir15)
    (calibration_target ins23 dir12)
    (calibration_target ins24 dir36)
    (calibration_target ins25 dir24)
    (calibration_target ins26 dir37)
    (calibration_target ins27 dir8)
    (calibration_target ins28 dir48)
    (calibration_target ins29 dir20)
    (calibration_target ins30 dir20)
    (calibration_target ins31 dir46)
    (calibration_target ins32 dir39)
    (calibration_target ins33 dir53)
    (calibration_target ins34 dir38)
    (calibration_target ins35 dir31)
    (calibration_target ins36 dir42)
    (calibration_target ins37 dir12)
    (calibration_target ins38 dir2)
    (calibration_target ins39 dir58)
    (calibration_target ins40 dir39)
    (calibration_target ins41 dir9)
    (calibration_target ins42 dir54)
    (calibration_target ins43 dir20)
    (calibration_target ins44 dir38)
    (calibration_target ins45 dir48)
    (calibration_target ins46 dir36)
    (calibration_target ins47 dir28)
    (calibration_target ins48 dir64)
    (calibration_target ins49 dir49)
    (calibration_target ins50 dir42)
    (calibration_target ins51 dir22)
    (calibration_target ins52 dir60)
    (calibration_target ins53 dir13)
    (calibration_target ins54 dir18)
    (calibration_target ins55 dir57)
    (calibration_target ins56 dir56)
    (calibration_target ins57 dir1)
    (calibration_target ins58 dir34)
    (calibration_target ins59 dir31)
    (calibration_target ins60 dir53)
    (calibration_target ins61 dir36)
    (calibration_target ins62 dir22)
    (calibration_target ins63 dir36)
    (calibration_target ins64 dir43)
    (calibration_target ins65 dir47)
    (calibration_target ins66 dir59)
    (calibration_target ins67 dir6)
    (calibration_target ins68 dir38)
    (calibration_target ins69 dir17)
    (calibration_target ins70 dir44)
    (calibration_target ins71 dir18)
    (calibration_target ins72 dir35)
    (calibration_target ins73 dir53)
    (calibration_target ins74 dir21)
    (calibration_target ins75 dir4)
    (calibration_target ins76 dir47)
    (calibration_target ins77 dir50)
    (calibration_target ins78 dir33)
    (calibration_target ins79 dir20)
    (calibration_target ins80 dir52)
    (calibration_target ins81 dir16)
    (calibration_target ins82 dir2)
    (calibration_target ins83 dir21)
    (calibration_target ins84 dir12)
    (calibration_target ins85 dir4)
    (calibration_target ins86 dir19)
    (calibration_target ins87 dir3)
    (calibration_target ins88 dir60)
    (calibration_target ins89 dir2)
    (calibration_target ins90 dir29)
    (calibration_target ins91 dir20)
    (calibration_target ins92 dir64)
    (calibration_target ins93 dir22)
    (calibration_target ins94 dir1)
    (calibration_target ins95 dir51)
    (calibration_target ins96 dir7)
    (calibration_target ins97 dir36)
    (calibration_target ins98 dir11)
    (calibration_target ins99 dir52)
    (calibration_target ins100 dir18)
    (calibration_target ins101 dir54)
    (calibration_target ins102 dir30)
    (calibration_target ins103 dir14)
    (calibration_target ins104 dir59)
    (calibration_target ins105 dir61)
    (calibration_target ins106 dir26)
    (calibration_target ins107 dir30)
    (calibration_target ins108 dir24)
    (calibration_target ins109 dir1)
    (calibration_target ins110 dir55)
    (on_board ins1 sat61)
    (on_board ins2 sat2)
    (on_board ins3 sat52)
    (on_board ins4 sat41)
    (on_board ins5 sat26)
    (on_board ins6 sat62)
    (on_board ins7 sat67)
    (on_board ins8 sat10)
    (on_board ins9 sat20)
    (on_board ins10 sat55)
    (on_board ins11 sat36)
    (on_board ins12 sat28)
    (on_board ins13 sat30)
    (on_board ins14 sat37)
    (on_board ins15 sat66)
    (on_board ins16 sat11)
    (on_board ins17 sat43)
    (on_board ins18 sat32)
    (on_board ins19 sat46)
    (on_board ins20 sat45)
    (on_board ins21 sat24)
    (on_board ins22 sat40)
    (on_board ins23 sat22)
    (on_board ins24 sat54)
    (on_board ins25 sat4)
    (on_board ins26 sat14)
    (on_board ins27 sat34)
    (on_board ins28 sat33)
    (on_board ins29 sat15)
    (on_board ins30 sat56)
    (on_board ins31 sat64)
    (on_board ins32 sat16)
    (on_board ins33 sat18)
    (on_board ins34 sat21)
    (on_board ins35 sat19)
    (on_board ins36 sat1)
    (on_board ins37 sat7)
    (on_board ins38 sat9)
    (on_board ins39 sat13)
    (on_board ins40 sat50)
    (on_board ins41 sat53)
    (on_board ins42 sat57)
    (on_board ins43 sat42)
    (on_board ins44 sat31)
    (on_board ins45 sat63)
    (on_board ins46 sat48)
    (on_board ins47 sat29)
    (on_board ins48 sat38)
    (on_board ins49 sat44)
    (on_board ins50 sat8)
    (on_board ins51 sat69)
    (on_board ins52 sat49)
    (on_board ins53 sat59)
    (on_board ins54 sat5)
    (on_board ins55 sat65)
    (on_board ins56 sat60)
    (on_board ins57 sat68)
    (on_board ins58 sat6)
    (on_board ins59 sat58)
    (on_board ins60 sat51)
    (on_board ins61 sat3)
    (on_board ins62 sat25)
    (on_board ins63 sat35)
    (on_board ins64 sat27)
    (on_board ins65 sat47)
    (on_board ins66 sat39)
    (on_board ins67 sat12)
    (on_board ins68 sat23)
    (on_board ins69 sat70)
    (on_board ins70 sat17)
    (on_board ins71 sat43)
    (on_board ins72 sat40)
    (on_board ins73 sat19)
    (on_board ins74 sat64)
    (on_board ins75 sat57)
    (on_board ins76 sat24)
    (on_board ins77 sat43)
    (on_board ins78 sat50)
    (on_board ins79 sat24)
    (on_board ins80 sat18)
    (on_board ins81 sat28)
    (on_board ins82 sat1)
    (on_board ins83 sat18)
    (on_board ins84 sat59)
    (on_board ins85 sat58)
    (on_board ins86 sat59)
    (on_board ins87 sat16)
    (on_board ins88 sat38)
    (on_board ins89 sat31)
    (on_board ins90 sat39)
    (on_board ins91 sat70)
    (on_board ins92 sat29)
    (on_board ins93 sat15)
    (on_board ins94 sat59)
    (on_board ins95 sat49)
    (on_board ins96 sat23)
    (on_board ins97 sat48)
    (on_board ins98 sat18)
    (on_board ins99 sat18)
    (on_board ins100 sat2)
    (on_board ins101 sat11)
    (on_board ins102 sat57)
    (on_board ins103 sat42)
    (on_board ins104 sat34)
    (on_board ins105 sat3)
    (on_board ins106 sat22)
    (on_board ins107 sat30)
    (on_board ins108 sat47)
    (on_board ins109 sat29)
    (on_board ins110 sat52)
    (supports ins8 mod3)
    (supports ins95 mod5)
    (supports ins85 mod1)
    (supports ins70 mod1)
    (supports ins106 mod1)
    (supports ins106 mod3)
    (supports ins38 mod1)
    (supports ins10 mod1)
    (supports ins3 mod5)
    (supports ins45 mod6)
    (supports ins96 mod2)
    (supports ins38 mod5)
    (supports ins22 mod1)
    (supports ins91 mod7)
    (supports ins75 mod3)
    (supports ins76 mod1)
    (supports ins73 mod7)
    (supports ins28 mod6)
    (supports ins54 mod1)
    (supports ins107 mod7)
    (supports ins47 mod1)
    (supports ins89 mod5)
    (supports ins57 mod5)
    (supports ins108 mod5)
    (supports ins35 mod6)
    (supports ins13 mod7)
    (supports ins30 mod1)
    (supports ins4 mod6)
    (supports ins100 mod7)
    (supports ins22 mod5)
    (supports ins55 mod1)
    (supports ins69 mod7)
    (supports ins103 mod2)
    (supports ins32 mod6)
    (supports ins47 mod7)
    (supports ins19 mod6)
    (supports ins41 mod3)
    (supports ins69 mod1)
    (supports ins83 mod1)
    (supports ins102 mod2)
    (supports ins40 mod4)
    (supports ins36 mod6)
    (supports ins7 mod7)
    (supports ins18 mod1)
    (supports ins17 mod1)
    (supports ins19 mod2)
    (supports ins46 mod1)
    (supports ins42 mod4)
    (supports ins44 mod3)
    (supports ins79 mod3)
    (supports ins96 mod6)
    (supports ins105 mod6)
    (supports ins89 mod6)
    (supports ins101 mod5)
    (supports ins30 mod5)
    (supports ins89 mod3)
    (supports ins103 mod3)
    (supports ins55 mod6)
    (supports ins49 mod1)
    (supports ins110 mod5)
    (supports ins52 mod5)
    (supports ins13 mod6)
    (supports ins81 mod4)
    (supports ins58 mod4)
    (supports ins75 mod2)
    (supports ins9 mod6)
    (supports ins53 mod3)
    (supports ins5 mod5)
    (supports ins72 mod6)
    (supports ins6 mod4)
    (supports ins45 mod3)
    (supports ins59 mod4)
    (supports ins8 mod2)
    (supports ins49 mod6)
    (supports ins100 mod5)
    (supports ins51 mod2)
    (supports ins44 mod5)
    (supports ins25 mod1)
    (supports ins55 mod5)
    (supports ins33 mod5)
    (supports ins37 mod6)
    (supports ins86 mod7)
    (supports ins109 mod2)
    (supports ins24 mod7)
    (supports ins46 mod6)
    (supports ins42 mod6)
    (supports ins95 mod1)
    (supports ins87 mod2)
    (supports ins75 mod6)
    (supports ins90 mod3)
    (supports ins77 mod6)
    (supports ins30 mod2)
    (supports ins51 mod4)
    (supports ins88 mod2)
    (supports ins97 mod7)
    (supports ins27 mod5)
    (supports ins26 mod7)
    (supports ins77 mod7)
    (supports ins86 mod2)
    (supports ins76 mod6)
    (supports ins81 mod7)
    (supports ins103 mod6)
    (supports ins70 mod4)
    (supports ins51 mod3)
    (supports ins43 mod4)
    (supports ins19 mod7)
    (supports ins77 mod2)
    (supports ins20 mod6)
    (supports ins91 mod3)
    (supports ins12 mod4)
    (supports ins8 mod6)
    (supports ins7 mod2)
    (supports ins49 mod5)
    (supports ins88 mod4)
    (supports ins64 mod4)
    (supports ins51 mod6)
    (supports ins96 mod7)
    (supports ins37 mod1)
    (supports ins48 mod3)
    (supports ins22 mod6)
    (supports ins53 mod7)
    (supports ins1 mod5)
    (supports ins63 mod2)
    (supports ins78 mod7)
    (supports ins32 mod4)
    (supports ins12 mod7)
    (supports ins86 mod3)
    (supports ins76 mod7)
    (supports ins18 mod4)
    (supports ins21 mod1)
    (supports ins96 mod3)
    (supports ins104 mod4)
    (supports ins9 mod5)
    (supports ins44 mod7)
    (supports ins84 mod5)
    (supports ins69 mod2)
    (supports ins31 mod4)
    (supports ins74 mod3)
    (supports ins61 mod6)
    (supports ins16 mod4)
    (supports ins38 mod6)
    (supports ins101 mod4)
    (supports ins67 mod5)
    (supports ins21 mod5)
    (supports ins105 mod2)
    (supports ins31 mod3)
    (supports ins94 mod6)
    (supports ins56 mod2)
    (supports ins62 mod5)
    (supports ins41 mod6)
    (supports ins43 mod6)
    (supports ins14 mod4)
    (supports ins5 mod4)
    (supports ins63 mod5)
    (supports ins108 mod7)
    (supports ins14 mod5)
    (supports ins66 mod5)
    (supports ins28 mod3)
    (supports ins30 mod6)
    (supports ins110 mod1)
    (supports ins83 mod2)
    (supports ins79 mod6)
    (supports ins77 mod1)
    (supports ins68 mod1)
    (supports ins71 mod6)
    (supports ins39 mod3)
    (supports ins21 mod2)
    (supports ins104 mod3)
    (supports ins34 mod7)
    (supports ins47 mod3)
    (supports ins80 mod3)
    (supports ins5 mod7)
    (supports ins109 mod6)
    (supports ins16 mod5)
    (supports ins81 mod5)
    (supports ins56 mod3)
    (supports ins16 mod6)
    (supports ins77 mod4)
    (supports ins51 mod1)
    (supports ins83 mod7)
    (supports ins50 mod2)
    (supports ins29 mod6)
    (supports ins70 mod3)
    (supports ins18 mod2)
    (supports ins64 mod7)
    (supports ins69 mod3)
    (supports ins37 mod4)
    (supports ins69 mod5)
    (supports ins108 mod1)
    (supports ins45 mod4)
    (supports ins28 mod4)
    (supports ins16 mod2)
    (supports ins38 mod7)
    (supports ins7 mod3)
    (supports ins109 mod1)
    (supports ins108 mod2)
    (supports ins93 mod7)
    (supports ins11 mod5)
    (supports ins56 mod5)
    (supports ins93 mod1)
    (supports ins6 mod7)
    (supports ins95 mod4)
    (supports ins55 mod2)
    (supports ins4 mod5)
    (supports ins80 mod7)
    (supports ins26 mod4)
    (supports ins90 mod4)
    (supports ins62 mod1)
    (supports ins54 mod4)
    (supports ins15 mod4)
    (supports ins98 mod3)
    (supports ins10 mod2)
    (supports ins82 mod1)
    (supports ins90 mod2)
    (supports ins99 mod2)
    (supports ins65 mod7)
    (supports ins63 mod6)
    (supports ins74 mod2)
    (supports ins27 mod3)
    (supports ins29 mod2)
    (supports ins94 mod2)
    (supports ins50 mod3)
    (supports ins94 mod3)
    (supports ins105 mod7)
    (supports ins82 mod5)
    (supports ins3 mod2)
    (supports ins31 mod1)
    (supports ins57 mod6)
    (supports ins5 mod1)
    (supports ins64 mod3)
    (supports ins56 mod4)
    (supports ins18 mod3)
    (supports ins36 mod5)
    (supports ins71 mod5)
    (supports ins19 mod3)
    (supports ins29 mod4)
    (supports ins55 mod7)
    (supports ins54 mod5)
    (supports ins75 mod7)
    (supports ins78 mod2)
    (supports ins72 mod3)
    (supports ins100 mod1)
    (supports ins50 mod1)
    (supports ins76 mod3)
    (supports ins16 mod1)
    (supports ins110 mod7)
    (supports ins45 mod5)
    (supports ins11 mod6)
    (supports ins47 mod4)
    (supports ins79 mod5)
    (supports ins8 mod1)
    (supports ins87 mod5)
    (supports ins48 mod2)
    (supports ins71 mod2)
    (supports ins80 mod1)
    (supports ins12 mod3)
    (supports ins64 mod6)
    (supports ins78 mod6)
    (supports ins5 mod6)
    (supports ins2 mod6)
    (supports ins10 mod7)
    (supports ins35 mod7)
    (supports ins34 mod6)
    (supports ins100 mod4)
    (supports ins43 mod1)
    (supports ins24 mod2)
    (supports ins48 mod4)
    (supports ins52 mod7)
    (supports ins42 mod5)
    (supports ins20 mod1)
    (supports ins71 mod7)
    (supports ins56 mod7)
    (supports ins87 mod7)
    (supports ins29 mod1)
    (supports ins5 mod2)
    (supports ins41 mod4)
    (supports ins65 mod1)
    (supports ins92 mod1)
    (supports ins47 mod2)
    (supports ins100 mod3)
    (supports ins6 mod2)
    (supports ins60 mod4)
    (supports ins99 mod4)
    (supports ins81 mod2)
    (supports ins32 mod1)
    (supports ins24 mod5)
    (supports ins26 mod6)
    (supports ins99 mod7)
    (supports ins98 mod7)
    (supports ins46 mod7)
    (supports ins27 mod2)
    (supports ins98 mod2)
    (supports ins91 mod2)
    (supports ins33 mod1)
    (supports ins83 mod5)
    (supports ins107 mod1)
    (supports ins32 mod2)
    (supports ins85 mod3)
    (supports ins88 mod3)
    (supports ins38 mod4)
    (supports ins67 mod6)
    (supports ins1 mod6)
    (supports ins40 mod2)
    (supports ins35 mod3)
    (supports ins92 mod7)
    (supports ins101 mod3)
    (supports ins85 mod5)
    (supports ins99 mod1)
    (supports ins107 mod5)
    (supports ins60 mod2)
    (supports ins99 mod5)
    (supports ins52 mod1)
    (supports ins59 mod2)
    (supports ins70 mod7)
    (supports ins71 mod1)
    (supports ins53 mod6)
    (supports ins82 mod4)
    (supports ins36 mod3)
    (supports ins85 mod6)
    (supports ins29 mod5)
    (supports ins1 mod1)
    (supports ins101 mod1)
    (supports ins51 mod5)
    (supports ins52 mod6)
    (supports ins95 mod6)
    (supports ins25 mod6)
    (supports ins23 mod6))
 (:goal  (and (pointing sat2 dir36)
   (pointing sat4 dir53)
   (pointing sat6 dir24)
   (pointing sat7 dir34)
   (pointing sat9 dir62)
   (pointing sat10 dir21)
   (pointing sat11 dir28)
   (pointing sat12 dir2)
   (pointing sat14 dir55)
   (pointing sat18 dir5)
   (pointing sat19 dir36)
   (pointing sat20 dir10)
   (pointing sat21 dir52)
   (pointing sat29 dir2)
   (pointing sat32 dir22)
   (pointing sat33 dir24)
   (pointing sat35 dir60)
   (pointing sat38 dir10)
   (pointing sat39 dir43)
   (pointing sat44 dir53)
   (pointing sat45 dir60)
   (pointing sat47 dir59)
   (pointing sat48 dir46)
   (pointing sat49 dir4)
   (pointing sat50 dir34)
   (pointing sat51 dir13)
   (pointing sat52 dir57)
   (pointing sat53 dir31)
   (pointing sat55 dir29)
   (pointing sat59 dir21)
   (pointing sat61 dir45)
   (pointing sat64 dir1)
   (pointing sat66 dir29)
   (pointing sat68 dir64)
   (pointing sat70 dir26)
   (have_image dir42 mod2)
   (have_image dir34 mod7)
   (have_image dir2 mod3)
   (have_image dir60 mod4)
   (have_image dir46 mod7)
   (have_image dir62 mod2)
   (have_image dir26 mod7)
   (have_image dir55 mod6)
   (have_image dir5 mod3)
   (have_image dir1 mod2)
   (have_image dir61 mod2)
   (have_image dir1 mod7)
   (have_image dir48 mod3)
   (have_image dir39 mod2)
   (have_image dir57 mod4)
   (have_image dir46 mod3)
   (have_image dir5 mod6)
   (have_image dir64 mod1)
   (have_image dir56 mod2)
   (have_image dir11 mod3)
   (have_image dir42 mod1)
   (have_image dir56 mod1)
   (have_image dir1 mod5)
   (have_image dir18 mod6)
   (have_image dir25 mod4)
   (have_image dir19 mod1)
   (have_image dir47 mod1)
   (have_image dir10 mod3)
   (have_image dir33 mod1)
   (have_image dir53 mod3)
   (have_image dir6 mod4)
   (have_image dir33 mod6)
   (have_image dir10 mod5)
   (have_image dir55 mod7)
   (have_image dir57 mod7)
   (have_image dir62 mod4)
   (have_image dir43 mod2)
   (have_image dir51 mod6)
   (have_image dir63 mod6)
   (have_image dir64 mod6)
   (have_image dir60 mod6)
   (have_image dir24 mod3)
   (have_image dir3 mod4)
   (have_image dir20 mod7)
   (have_image dir29 mod7)
   (have_image dir12 mod5)
   (have_image dir10 mod4)
   (have_image dir18 mod3)
   (have_image dir53 mod5)
   (have_image dir20 mod2)
   (have_image dir51 mod7)
   (have_image dir14 mod6)
   (have_image dir24 mod2)
   (have_image dir48 mod6)
   (have_image dir21 mod3)
   (have_image dir21 mod4)
   (have_image dir27 mod2)
   (have_image dir8 mod6)
   (have_image dir7 mod3)
   (have_image dir4 mod7)
   (have_image dir56 mod6)
   (have_image dir32 mod6)
   (have_image dir59 mod7)
   (have_image dir53 mod6)
   (have_image dir48 mod7)
   (have_image dir63 mod7)
   (have_image dir12 mod1)
   (have_image dir4 mod2)
   (have_image dir62 mod7)
   (have_image dir34 mod6)
   (have_image dir55 mod3)
   (have_image dir50 mod7)
   (have_image dir57 mod5)
   (have_image dir43 mod4)
   (have_image dir59 mod4)
   (have_image dir43 mod5)
   (have_image dir49 mod3)
   (have_image dir4 mod5)
   (have_image dir15 mod1)
   (have_image dir43 mod7)
   (have_image dir8 mod3)
   (have_image dir45 mod4)
   (have_image dir61 mod5)
   (have_image dir28 mod4)
   (have_image dir41 mod3)
   (have_image dir18 mod5)
   (have_image dir38 mod3)
   (have_image dir42 mod5)
   (have_image dir2 mod1)
   (have_image dir17 mod7)
   (have_image dir51 mod5)
   (have_image dir32 mod3)
   (have_image dir31 mod6)
   (have_image dir19 mod6)
   (have_image dir30 mod7)
   (have_image dir13 mod4)
   (have_image dir56 mod5)
   (have_image dir26 mod5)
   (have_image dir1 mod6)
   (have_image dir43 mod1)
   (have_image dir18 mod1)
   (have_image dir37 mod3)
   (have_image dir34 mod1)
   (have_image dir16 mod3)
   (have_image dir23 mod4)
   (have_image dir22 mod2)
   (have_image dir48 mod1)
   (have_image dir35 mod6)
   (have_image dir11 mod6)
   (have_image dir27 mod6)
   (have_image dir22 mod4)
   (have_image dir52 mod4)
   (have_image dir61 mod4)
   (have_image dir12 mod4)
   (have_image dir61 mod1)
   (have_image dir17 mod4)
   (have_image dir54 mod2)
   (have_image dir50 mod6)
   (have_image dir15 mod6)
   (have_image dir5 mod4)
   (have_image dir2 mod5)
   (have_image dir24 mod5)
   (have_image dir35 mod3)
   (have_image dir25 mod1)
   (have_image dir45 mod7)
   (have_image dir22 mod1)
   (have_image dir8 mod5)
   (have_image dir31 mod2)
   (have_image dir39 mod3)
   (have_image dir40 mod7)
   (have_image dir61 mod3)
   (have_image dir28 mod7)
   (have_image dir14 mod1)
   (have_image dir35 mod1)
   (have_image dir22 mod5)
   (have_image dir56 mod7)
   (have_image dir58 mod2)
   (have_image dir58 mod4)
   (have_image dir23 mod6)
   (have_image dir30 mod4)
   (have_image dir5 mod2)
   (have_image dir32 mod2)
   (have_image dir55 mod2)
   (have_image dir29 mod6)
   (have_image dir9 mod3)
   (have_image dir5 mod7)
   (have_image dir45 mod1)
   (have_image dir14 mod3)
   (have_image dir27 mod3)
   (have_image dir6 mod2)
   (have_image dir30 mod2)
   (have_image dir64 mod3)
   (have_image dir19 mod3)
   (have_image dir41 mod2)
   (have_image dir34 mod3)
   (have_image dir62 mod5)
   (have_image dir5 mod1)
   (have_image dir36 mod1)
   (have_image dir50 mod3)
   (have_image dir50 mod4)
   (have_image dir32 mod5)
   (have_image dir30 mod1)
   (have_image dir23 mod1)
   (have_image dir2 mod7)
   (have_image dir28 mod2)
   (have_image dir7 mod5)
   (have_image dir19 mod2)
   (have_image dir15 mod5)
   (have_image dir32 mod4)
   (have_image dir9 mod6)
   (have_image dir11 mod2)
   (have_image dir11 mod7)
   (have_image dir45 mod6)
   (have_image dir38 mod7)
   (have_image dir54 mod1)
   (have_image dir26 mod3)
   (have_image dir43 mod3)
   (have_image dir57 mod2)
   (have_image dir36 mod4)
   (have_image dir6 mod5)
   (have_image dir63 mod5)
   (have_image dir26 mod4)
   (have_image dir55 mod1)
   (have_image dir59 mod5)
   (have_image dir53 mod1)
   (have_image dir12 mod7)
   (have_image dir12 mod2)
   (have_image dir7 mod7)
   (have_image dir14 mod5)
   (have_image dir11 mod1)
   (have_image dir44 mod2)
   (have_image dir49 mod1)
   (have_image dir35 mod7)
   (have_image dir60 mod1)
   (have_image dir47 mod5)
   (have_image dir31 mod5)
   (have_image dir33 mod3)
   (have_image dir19 mod7)
   (have_image dir24 mod7)
   (have_image dir21 mod6)
   (have_image dir27 mod1)
   (have_image dir6 mod3)
   (have_image dir59 mod6)
   (have_image dir29 mod2)
   (have_image dir4 mod1)
   (have_image dir64 mod4)
   (have_image dir33 mod5)
   (have_image dir38 mod6)
   (have_image dir22 mod6)
   (have_image dir37 mod6)
   (have_image dir23 mod7)
   (have_image dir34 mod2)
   (have_image dir18 mod2)
   (have_image dir44 mod3)
   (have_image dir33 mod2)
   (have_image dir15 mod4)
   (have_image dir33 mod4)
   (have_image dir13 mod7)
   (have_image dir9 mod7)
   (have_image dir34 mod4)
   (have_image dir6 mod1)
   (have_image dir63 mod1)
   (have_image dir4 mod3)
   (have_image dir58 mod5)
   (have_image dir27 mod5)
   (have_image dir17 mod6)
   (have_image dir48 mod4)
   (have_image dir16 mod5)
   (have_image dir19 mod5)
   (have_image dir43 mod6)
   (have_image dir38 mod2)
   (have_image dir15 mod3)
   (have_image dir21 mod2)
   (have_image dir28 mod5)
   (have_image dir10 mod7)
   (have_image dir35 mod4)
   (have_image dir35 mod2)
   (have_image dir51 mod4)
   (have_image dir1 mod4)
   (have_image dir8 mod7)
   (have_image dir63 mod3)
   (have_image dir16 mod2))))