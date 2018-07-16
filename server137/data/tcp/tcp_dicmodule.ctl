options(bindsize=65536000,readsize=80000000,rows=10000)
load data
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './eas_dic_module.bad'
DISCARDFILE './eas_dic_module.dsc'
replace into table eas_dic_module
fields terminated by ','
trailing nullcols
(
Diccode  "TRIM(:diccode)",
dicname  "TRIM(:dicname)"
)
begindata
