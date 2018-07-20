options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './cps_gradstudent.bad'
DISCARDFILE './cps_gradstudent.dsc'
truncate into table cps_studentgraduate
fields terminated by ','
trailing nullcols
(
seg       FILLER,
SN         "TO_NUMBER(:SN)",
StudentCode  "TRIM(:StudentCode)",
RegisterCertNo  "TRIM(:RegisterCertNo)",
DegreeCertNO  "TRIM(:DegreeCertNO)",
yxkml "TRIM(:yxkml)",
bynd "TRIM(:bynd)",
Byxq  "TRIM(:Byxq)",
bybz "TRIM(:bybz)",
xwbz "TRIM(:xwbz)",
yzyccdm "TRIM(:yzyccdm)",
ybysj "TRIM(:ybysj)",
zplj "TRIM(:zplj)",
zpljdybz "TRIM(:zpljdybz)",
bz1 DATE "yyyy-mm-dd" NULLIF (bz1="NULL"),
ybyxx "TRIM(:ybyxx)",
ylzy "TRIM(:ylzy)"
)
begindata
