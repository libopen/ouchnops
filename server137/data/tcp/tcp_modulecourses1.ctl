options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_tcp_modulecourses1.bad'
DISCARDFILE './eas_tcp_modulecourses1.dsc'
truncate into table eas_tcp_modulecourses1
fields terminated by ','
trailing nullcols
(
SN  "TRIM(:SN)",
ModuleCode  "TRIM(:ModuleCode)",
BatchCode  "TRIM(:BatchCode)",
TCPCode  "TRIM(:TCPCode)",
CourseID  "TRIM(:CourseID)",
CourseName  "TRIM(:CourseName)",
CourseNature  "TRIM(:CourseNature)",
OrgCode  "TRIM(:OrgCode)",
Credit  "TO_NUMBER(:Credit)",
hour  "TO_NUMBER(:hour)",
OpenedSemester  "TO_NUMBER(:OpenedSemester)",
ExamUnitType  "TRIM(:ExamUnitType)",
IsExtendedCourse  "TO_NUMBER(:IsExtendedCourse)",
IsDegreeCourse  "TO_NUMBER(:IsDegreeCourse)",
IsSimilar  "TO_NUMBER(:IsSimilar)",
IsMutex  "TO_NUMBER(:IsMutex)",
CreateTime DATE"yyyy-mm-dd"NULLIF (CreateTime="NULL")
)
begindata


