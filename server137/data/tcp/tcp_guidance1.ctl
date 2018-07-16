options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_tcp_Guidance1.bad'
DISCARDFILE './eas_tcp_Guidance1.dsc'
truncate into table eas_tcp_Guidance1
fields terminated by ','
trailing nullcols
(
TCPCode  "TRIM(:TCPCode)",
BatchCode  "TRIM(:BatchCode)",
TCPName  "TRIM(:TCPName)",
EducationType  "TRIM(:EducationType)",
StudentType  "TRIM(:StudentType)",
ProfessionalLevel  "TRIM(:ProfessionalLevel)",
SpyCode  "TRIM(:SpyCode)",
MinGradCredits  "TO_NUMBER(:MinGradCredits)",
MinExamCredits  "TO_NUMBER(:MinExamCredits)",
ExemptionMaxCredits  "TO_NUMBER(:ExemptionMaxCredits)",
SchoolSystem  "TO_NUMBER(:SchoolSystem)",
DegreeCollegeID  "TO_NUMBER(:DegreeCollegeID)",
DegreeSemester  "TRIM(:DegreeSemester)",
State  "TRIM(:State)",
Creator  "TRIM(:Creator)",
CreateTime DATE"yyyymmdd"NULLIF (CreateTime="NULL"),
EnableUser  "TRIM(:EnableUser)",
EnableTime DATE"yyyymmdd"NULLIF (EnableTime="NULL")
)
begindata
