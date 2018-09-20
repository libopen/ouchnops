options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './cps_student.bad'
DISCARDFILE './cps_student.dsc'
truncate into table cps_student
fields terminated by ','
trailing nullcols
(
StudentID  "TRIM(:StudentID)",
LearningCenterCode  "TRIM(:LearningCenterCode)",
SpyCode  "TRIM(:SpyCode)",
newTCPCode  "TRIM(:newTCPCode)",
ClassCode  "TRIM(:ClassCode)"
)
begindata
1611001451306,3300803,11030100,160901411030100,163300803014504
1635001203479,3300601,11020300,160301211020300,163300601012001
1733101402255,3301700,11020122,170301411020122,173301381014010
