options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_tcp_module1.bad'
DISCARDFILE './eas_tcp_module1.dsc'
truncate into table eas_tcp_module1
fields terminated by ','
trailing nullcols
(
SN  "TRIM(:SN)",
BatchCode  "TRIM(:BatchCode)",
TCPCode  "TRIM(:TCPCode)",
ModuleCode  "TRIM(:ModuleCode)",
MinGradCredits  "TO_NUMBER(:MinGradCredits)",
MinExamCredits  "TO_NUMBER(:MinExamCredits)"
)
begindata
