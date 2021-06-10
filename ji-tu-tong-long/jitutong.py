def wbbb (allaz, webiaz, baboaz):
    
    all_a, all_z = allaz
    webi_a, webi_z = webiaz
    babo_a, babo_z = baboaz
    
    ## 先求 webi 再求 babo , 用头的式子代入足的式子
    webi_hoo_az = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a)
    then_babo_hoo_az = all_a / babo_a - webi_hoo_az * webi_a / babo_a

    ## 先求 webi 再求 babo , 用足的式子代入头的式子
    webi_hoo_za = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z)
    then_babo_hoo_za = all_z / babo_z - webi_hoo_za * webi_z / babo_z

    ## 先求 babo 再求 webi , 用头的式子代入足的式子
    babo_hoo_az = (all_z - webi_z * all_a / webi_a) / (babo_z - webi_z * babo_a / webi_a)
    then_webi_hoo_az = all_a / webi_a - babo_hoo_az * babo_a / webi_a

    ## 先求 babo 再求 webi , 用足的式子代入头的式子
    babo_hoo_za = (all_a - webi_a * all_z / webi_z) / (babo_a - webi_a * babo_z / webi_z)
    then_webi_hoo_za = all_z / webi_z - babo_hoo_za * babo_z / webi_z
    
    return [ ("webi_then_babo_az", (webi_hoo_az, then_babo_hoo_az) ) ,
             ("webi_then_babo_za", (webi_hoo_za, then_babo_hoo_za) ) ,
             ("babo_then_webi_az", (then_webi_hoo_az, babo_hoo_az) ) ,
             ("babo_then_webi_za", (then_webi_hoo_za, babo_hoo_za) ) ]

### >>> wbbb((609,204), (3,6), (7,1))
### [('webi_then_babo_az', (21.0, 78.0)), ('webi_then_babo_za', (21.0, 78.0)), ('babo_then_webi_az', (21.0, 78.0)), ('babo_then_webi_za', (21.0, 78.0))]
