# coding: utf-8
from dbfread import DBF
import sys
dbffile=sys.argv[1]
csvfile=sys.argv[2]
tb=DBF(dbffile)
tb.encoding='gb18030'
f=open(csvfile,'w+')
for row in tb:
    print("{},{},{},end\r".format(row['XH'],row['KSH'],row['SFZH']),file=f)
    
f.close()
