;; blocks=194, out_folder=testing/hard, instance_id=4, seed=1010

(define (problem blocksworld-04)
 (:domain blocksworld)
 (:objects b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15 b16 b17 b18 b19 b20 b21 b22 b23 b24 b25 b26 b27 b28 b29 b30 b31 b32 b33 b34 b35 b36 b37 b38 b39 b40 b41 b42 b43 b44 b45 b46 b47 b48 b49 b50 b51 b52 b53 b54 b55 b56 b57 b58 b59 b60 b61 b62 b63 b64 b65 b66 b67 b68 b69 b70 b71 b72 b73 b74 b75 b76 b77 b78 b79 b80 b81 b82 b83 b84 b85 b86 b87 b88 b89 b90 b91 b92 b93 b94 b95 b96 b97 b98 b99 b100 b101 b102 b103 b104 b105 b106 b107 b108 b109 b110 b111 b112 b113 b114 b115 b116 b117 b118 b119 b120 b121 b122 b123 b124 b125 b126 b127 b128 b129 b130 b131 b132 b133 b134 b135 b136 b137 b138 b139 b140 b141 b142 b143 b144 b145 b146 b147 b148 b149 b150 b151 b152 b153 b154 b155 b156 b157 b158 b159 b160 b161 b162 b163 b164 b165 b166 b167 b168 b169 b170 b171 b172 b173 b174 b175 b176 b177 b178 b179 b180 b181 b182 b183 b184 b185 b186 b187 b188 b189 b190 b191 b192 b193 b194 - object)
 (:init 
    (arm-empty)
    (clear b44)
    (on b44 b72)
    (on b72 b93)
    (on b93 b19)
    (on b19 b102)
    (on b102 b97)
    (on b97 b79)
    (on b79 b47)
    (on b47 b66)
    (on b66 b154)
    (on b154 b181)
    (on b181 b177)
    (on b177 b113)
    (on b113 b42)
    (on b42 b110)
    (on b110 b178)
    (on b178 b140)
    (on b140 b30)
    (on b30 b118)
    (on b118 b138)
    (on b138 b18)
    (on b18 b143)
    (on b143 b135)
    (on b135 b174)
    (on b174 b134)
    (on b134 b40)
    (on b40 b132)
    (on b132 b190)
    (on b190 b71)
    (on b71 b62)
    (on b62 b171)
    (on b171 b90)
    (on b90 b187)
    (on b187 b26)
    (on b26 b180)
    (on b180 b55)
    (on b55 b129)
    (on b129 b125)
    (on b125 b158)
    (on b158 b169)
    (on b169 b115)
    (on-table b115)
    (clear b21)
    (on b21 b108)
    (on b108 b191)
    (on b191 b160)
    (on b160 b150)
    (on b150 b116)
    (on b116 b120)
    (on b120 b119)
    (on b119 b163)
    (on b163 b60)
    (on b60 b127)
    (on b127 b99)
    (on b99 b54)
    (on b54 b9)
    (on b9 b78)
    (on b78 b162)
    (on b162 b81)
    (on b81 b141)
    (on-table b141)
    (clear b16)
    (on b16 b76)
    (on b76 b161)
    (on-table b161)
    (clear b48)
    (on b48 b56)
    (on b56 b25)
    (on b25 b103)
    (on b103 b105)
    (on b105 b173)
    (on b173 b144)
    (on b144 b2)
    (on b2 b75)
    (on b75 b192)
    (on b192 b34)
    (on b34 b35)
    (on b35 b91)
    (on b91 b89)
    (on b89 b41)
    (on b41 b52)
    (on b52 b33)
    (on b33 b156)
    (on b156 b84)
    (on b84 b100)
    (on b100 b86)
    (on b86 b31)
    (on-table b31)
    (clear b58)
    (on b58 b3)
    (on b3 b82)
    (on b82 b147)
    (on b147 b70)
    (on b70 b68)
    (on b68 b114)
    (on b114 b12)
    (on b12 b87)
    (on b87 b24)
    (on b24 b1)
    (on b1 b65)
    (on b65 b117)
    (on b117 b166)
    (on b166 b39)
    (on b39 b194)
    (on b194 b128)
    (on b128 b121)
    (on b121 b63)
    (on b63 b13)
    (on b13 b159)
    (on b159 b32)
    (on b32 b27)
    (on b27 b107)
    (on b107 b104)
    (on b104 b186)
    (on b186 b157)
    (on b157 b15)
    (on b15 b67)
    (on b67 b126)
    (on-table b126)
    (clear b50)
    (on b50 b6)
    (on b6 b176)
    (on b176 b168)
    (on b168 b152)
    (on b152 b184)
    (on-table b184)
    (clear b57)
    (on b57 b109)
    (on b109 b85)
    (on b85 b94)
    (on b94 b29)
    (on b29 b80)
    (on-table b80)
    (clear b10)
    (on b10 b46)
    (on b46 b96)
    (on b96 b11)
    (on b11 b98)
    (on b98 b122)
    (on b122 b124)
    (on b124 b23)
    (on-table b23)
    (clear b83)
    (on b83 b36)
    (on b36 b88)
    (on b88 b183)
    (on b183 b167)
    (on b167 b61)
    (on b61 b77)
    (on b77 b164)
    (on b164 b145)
    (on b145 b153)
    (on-table b153)
    (clear b59)
    (on b59 b51)
    (on b51 b73)
    (on b73 b151)
    (on-table b151)
    (clear b149)
    (on-table b149)
    (clear b146)
    (on-table b146)
    (clear b14)
    (on b14 b139)
    (on b139 b17)
    (on b17 b8)
    (on b8 b5)
    (on b5 b182)
    (on b182 b111)
    (on b111 b49)
    (on-table b49)
    (clear b7)
    (on b7 b45)
    (on b45 b179)
    (on-table b179)
    (clear b185)
    (on b185 b175)
    (on b175 b74)
    (on b74 b142)
    (on-table b142)
    (clear b170)
    (on-table b170)
    (clear b136)
    (on b136 b4)
    (on b4 b20)
    (on-table b20)
    (clear b133)
    (on b133 b95)
    (on b95 b193)
    (on-table b193)
    (clear b123)
    (on b123 b101)
    (on b101 b38)
    (on b38 b148)
    (on-table b148)
    (clear b69)
    (on b69 b92)
    (on b92 b130)
    (on b130 b165)
    (on b165 b131)
    (on b131 b28)
    (on b28 b53)
    (on b53 b188)
    (on b188 b37)
    (on b37 b43)
    (on b43 b189)
    (on b189 b112)
    (on b112 b106)
    (on b106 b22)
    (on b22 b137)
    (on-table b137)
    (clear b64)
    (on-table b64)
    (clear b155)
    (on-table b155)
    (clear b172)
    (on-table b172))
 (:goal  (and 
    (clear b73)
    (on b73 b167)
    (on b167 b127)
    (on b127 b133)
    (on b133 b45)
    (on b45 b1)
    (on b1 b80)
    (on b80 b161)
    (on b161 b71)
    (on b71 b60)
    (on-table b60)
    (clear b147)
    (on b147 b49)
    (on b49 b24)
    (on b24 b89)
    (on b89 b7)
    (on b7 b28)
    (on b28 b86)
    (on b86 b44)
    (on b44 b76)
    (on b76 b36)
    (on b36 b182)
    (on-table b182)
    (clear b74)
    (on b74 b38)
    (on b38 b33)
    (on b33 b104)
    (on b104 b88)
    (on b88 b156)
    (on-table b156)
    (clear b19)
    (on b19 b47)
    (on b47 b153)
    (on b153 b8)
    (on b8 b158)
    (on b158 b62)
    (on b62 b82)
    (on-table b82)
    (clear b191)
    (on b191 b14)
    (on b14 b17)
    (on b17 b180)
    (on b180 b52)
    (on b52 b12)
    (on b12 b103)
    (on b103 b107)
    (on b107 b168)
    (on b168 b144)
    (on-table b144)
    (clear b20)
    (on b20 b120)
    (on b120 b13)
    (on b13 b94)
    (on b94 b140)
    (on b140 b166)
    (on b166 b66)
    (on b66 b92)
    (on b92 b3)
    (on b3 b141)
    (on b141 b116)
    (on b116 b72)
    (on b72 b75)
    (on b75 b27)
    (on b27 b176)
    (on b176 b193)
    (on b193 b114)
    (on b114 b178)
    (on b178 b9)
    (on b9 b155)
    (on b155 b46)
    (on b46 b118)
    (on-table b118)
    (clear b112)
    (on b112 b69)
    (on b69 b142)
    (on-table b142)
    (clear b169)
    (on b169 b179)
    (on-table b179)
    (clear b148)
    (on b148 b18)
    (on b18 b40)
    (on b40 b163)
    (on b163 b93)
    (on b93 b117)
    (on b117 b85)
    (on b85 b68)
    (on b68 b57)
    (on b57 b23)
    (on b23 b184)
    (on-table b184)
    (clear b188)
    (on b188 b105)
    (on b105 b95)
    (on b95 b59)
    (on b59 b131)
    (on b131 b151)
    (on b151 b146)
    (on b146 b101)
    (on b101 b100)
    (on b100 b31)
    (on b31 b29)
    (on b29 b139)
    (on b139 b115)
    (on b115 b125)
    (on b125 b138)
    (on b138 b111)
    (on b111 b11)
    (on b11 b42)
    (on b42 b149)
    (on b149 b5)
    (on b5 b123)
    (on b123 b121)
    (on b121 b189)
    (on b189 b83)
    (on b83 b79)
    (on b79 b186)
    (on b186 b150)
    (on b150 b173)
    (on b173 b113)
    (on b113 b108)
    (on b108 b37)
    (on b37 b97)
    (on b97 b4)
    (on b4 b48)
    (on b48 b175)
    (on b175 b91)
    (on b91 b16)
    (on b16 b21)
    (on b21 b192)
    (on b192 b35)
    (on b35 b122)
    (on-table b122)
    (clear b177)
    (on b177 b165)
    (on b165 b55)
    (on b55 b15)
    (on b15 b98)
    (on b98 b99)
    (on b99 b159)
    (on b159 b126)
    (on b126 b174)
    (on b174 b50)
    (on b50 b2)
    (on b2 b172)
    (on b172 b84)
    (on b84 b130)
    (on b130 b67)
    (on b67 b183)
    (on-table b183)
    (clear b194)
    (on b194 b106)
    (on b106 b54)
    (on-table b54)
    (clear b10)
    (on b10 b143)
    (on b143 b22)
    (on b22 b137)
    (on b137 b39)
    (on b39 b63)
    (on b63 b78)
    (on b78 b132)
    (on b132 b119)
    (on b119 b164)
    (on b164 b157)
    (on b157 b110)
    (on b110 b162)
    (on b162 b109)
    (on b109 b154)
    (on b154 b26)
    (on b26 b70)
    (on-table b70)
    (clear b128)
    (on b128 b51)
    (on b51 b34)
    (on b34 b77)
    (on b77 b58)
    (on b58 b30)
    (on b30 b190)
    (on b190 b87)
    (on b87 b170)
    (on b170 b181)
    (on b181 b96)
    (on b96 b171)
    (on b171 b53)
    (on b53 b64)
    (on b64 b185)
    (on b185 b81)
    (on b81 b134)
    (on b134 b160)
    (on b160 b129)
    (on b129 b6)
    (on b6 b145)
    (on b145 b43)
    (on b43 b32)
    (on b32 b41)
    (on b41 b187)
    (on-table b187)
    (clear b90)
    (on b90 b135)
    (on b135 b136)
    (on b136 b65)
    (on b65 b56)
    (on b56 b61)
    (on b61 b102)
    (on b102 b25)
    (on b25 b124)
    (on b124 b152)
    (on-table b152))))
