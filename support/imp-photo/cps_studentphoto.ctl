options(bindsize=6553600,readsize=9000000,rows=1000)
load data 
CHARACTERSET ZHS16GBK 
infile *
BADFILE  './cps_studentphoto.bad'DISCARDFILE './cps_studentphoto.dsc'
truncate into table cps_studentphoto
fields terminated by ','
trailing nullcols
(
idnumber "TRIM(:idnumber)",
StudentID  "TRIM(:StudentID)",
maintainer "trim(:maintainer)",
photo      "trim(:photo)",
StorePath  "TRIM(:StorePath)",
phototype  "trim(:phototype)",
photosize  "to_number(:photosize)"
)
begindata

