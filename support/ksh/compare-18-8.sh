awk -F, '{ split($11,arr,"/");if ((arr[1]!=substr($10,1,4))||
(substr(arr[2],length(arr[2]),1)!=substr($10,6,1)) ||
(substr(arr[3],length(arr[3]),1)!=substr($10,8,1))) 
               {print "CSRQ:",$0} 
    if($2!=$3) {print "XM  :",$0} 
    if($4!=$5) {print "SFZH:",$0}
    if($6!=$7) {print "XB  :",$0}
    if($8!=$9) {print "MZ  :",$0}}' 18-8-cmp.csv

