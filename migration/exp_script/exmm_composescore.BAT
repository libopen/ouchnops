rem %1 dbname %2 expFile %3 dbip %4 Uid %5 pwd 
setlocal enabledelayedexpansion
set lv1=%1
set lv2=%2
set lv3=%3
set lv4=%4
set lv5=%5

set dbcode[0]=110
set dbcode[1]=120
set dbcode[2]=130
set dbcode[3]=140
set dbcode[4]=150
set dbcode[5]=210
set dbcode[6]=211
set dbcode[7]=212
set dbcode[8]=220
set dbcode[9]=221
set dbcode[10]=230
set dbcode[11]=231
set dbcode[12]=310
set dbcode[13]=320
set dbcode[14]=321
set dbcode[15]=330
set dbcode[16]=331
set dbcode[17]=340
set dbcode[18]=350
set dbcode[19]=351
set dbcode[20]=360
set dbcode[21]=370
set dbcode[22]=371
set dbcode[23]=410
set dbcode[24]=420
set dbcode[25]=421
set dbcode[26]=430
set dbcode[27]=440
set dbcode[28]=441
set dbcode[29]=442
set dbcode[30]=450
set dbcode[31]=460
set dbcode[32]=510
set dbcode[33]=511
set dbcode[34]=512
set dbcode[35]=520
set dbcode[36]=530
set dbcode[37]=610
set dbcode[38]=611
set dbcode[39]=620
set dbcode[40]=630
set dbcode[41]=640
set dbcode[42]=650
set dbcode[43]=651
set dbcode[44]=801
set dbcode[45]=802
set dbcode[46]=803
set dbcode[47]=804
set dbcode[48]=805
set dbcode[49]=806
set dbcode[50]=901
set dbcode[51]=902
set dbcode[52]=903
set dbcode[53]=904
set dbcode[54]=905
set dbcode[55]=906
set dbcode[56]=907

for /l %%n in (0,1,56) do (
call %~dp0/exp_composescore.bat %lv1% %lv2% %lv3% %lv4% !lv5! !dbcode[%%n]!

)
set count=0
