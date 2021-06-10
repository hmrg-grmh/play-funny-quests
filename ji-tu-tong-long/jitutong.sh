# wbbb ()
# {
#     # eg: wbbb 609,204 3,6 7,1
#     all_a="$(echo "$1"|cut -d, -f1)"    all_z="$(echo "$1"|cut -d, -f2)" &&
#     webi_a="$(echo "$1"|cut -d, -f1)"   webi_z="$(echo "$1"|cut -d, -f2)" &&
#     babo_a="$(echo "$1"|cut -d, -f1)"   babo_z="$(echo "$1"|cut -d, -f2)" &&
#     
#     
#     (( webi_hoo_az = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a) )) &&
#     (( then_babo_hoo_az = all_a / babo_a - webi_hoo_az * webi_a / babo_a )) &&
# 
#     (( webi_hoo_za = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z) )) &&
#     (( then_babo_hoo_za = all_z / babo_z - webi_hoo_za * webi_z / babo_z )) &&
# 
#     (( babo_hoo_az = (all_z - webi_z * all_a / webi_a) / (babo_z - webi_z * babo_a / webi_a) )) &&
#     (( then_webi_hoo_az = all_a / webi_a - babo_hoo_az * babo_a / webi_a )) &&
# 
#     (( babo_hoo_za = (all_a - webi_a * all_z / webi_z) / (babo_a - webi_a * babo_z / webi_z) )) &&
#     (( then_webi_hoo_za = all_z / webi_z - babo_hoo_za * babo_z / webi_z )) &&
#     
#     
#     echo "webi_then_babo_az:" $webi_hoo_az,$then_babo_hoo_az &&
#     echo "webi_then_babo_za:" $webi_hoo_za,$then_babo_hoo_za &&
#     echo "babo_then_webi_az:" $then_webi_hoo_az,$babo_hoo_az &&
#     echo "babo_then_webi_za:" $then_webi_hoo_za,$babo_hoo_za &&
#     
#     echo ;
# } ;

## 上面是失败例子，仅作参考。

## 这里开始是想用双括号计算的。
## 但那玩意儿只支持整数，不支持精细的运算。
## Bc 不便于格式化输出。用 AWK 吧。

wbbb ()
{
    # eg: echo 609,204 3,6 7,1 | wbbb
    awk '
    {
        splitd = "," ;
        split ($1, allaz, splitd) ;
        split ($2, webiaz, splitd) ;
        split ($3, baboaz, splitd) ;
        
        all_a = allaz[1] ; all_z = allaz[2] ;
        webi_a = webiaz[1] ; webi_z = webiaz[2] ;
        babo_a = baboaz[1] ; babo_z = baboaz[2] ;
        
        
        webi_hoo_az = (all_z - babo_z * all_a / babo_a) / (webi_z - babo_z * webi_a / babo_a) ;
        then_babo_hoo_az = all_a / babo_a - webi_hoo_az * webi_a / babo_a ;

        webi_hoo_za = (all_a - babo_a * all_z / babo_z) / (webi_a - babo_a * webi_z / babo_z) ;
        then_babo_hoo_za = all_z / babo_z - webi_hoo_za * webi_z / babo_z ;

        babo_hoo_az = (all_z - webi_z * all_a / webi_a) / (babo_z - webi_z * babo_a / webi_a) ;
        then_webi_hoo_az = all_a / webi_a - babo_hoo_az * babo_a / webi_a ;

        babo_hoo_za = (all_a - webi_a * all_z / webi_z) / (babo_a - webi_a * babo_z / webi_z) ;
        then_webi_hoo_za = all_z / webi_z - babo_hoo_za * babo_z / webi_z ;
        
        
        print "webi_then_babo_az:", webi_hoo_az, then_babo_hoo_az ;
        print "webi_then_babo_za:", webi_hoo_za, then_babo_hoo_za ;
        print "babo_then_webi_az:", then_webi_hoo_az, babo_hoo_az ;
        print "babo_then_webi_za:", then_webi_hoo_za, babo_hoo_za ;
        
    } ' ;
} ;
