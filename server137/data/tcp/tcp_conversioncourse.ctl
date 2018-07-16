options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_tcp_conversioncourse.bad'
DISCARDFILE './eas_tcp_conversioncourse.dsc'
append into table EAS_TCP_ConversionCourse
fields terminated by ','
trailing nullcols
(
SN  "TRIM(:SN)",
BatchCode  "TRIM(:BatchCode)",
TCPCode  "TRIM(:TCPCode)",
CourseID  "TRIM(:CourseID)",
SuggestOpenSemester  "TO_NUMBER(:SuggestOpenSemester)",
ExamUnitType  "TRIM(:ExamUnitType)",
CreateTime DATE"yyyy-mm-dd"NULLIF (CreateTime="NULL")
)
begindata
