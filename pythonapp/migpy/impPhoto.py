# -*- coding: utf-8 -*-
import os
import sys
from os.path import basename
import datetime
from sqlalchemy import create_engine
import json

def getphotoinfo(filename):
    photoinfo=[]
    sql = 'select a.studentid,a.batchcode,a.professionallevel,a.studenttype from eas_schroll_student a inner join eas_schroll_studentbasicinfo b on a.studentid=b.studentid where b.idnumber=:idnumber'
    result =engine.execute(sql,idnumber=filename)
    for row in result:
        filepath='%s/%s/%s'%(row[3],row[2],row[1])
        print(filepath)
        photoinfo.append('"%s":"%s"'%(row[0],filepath))
    return ','.join(photoinfo)
            

def getfiles(rootDir):
    for lists in os.listdir(rootDir):
        path = os.path.join(rootDir,lists)
        if os.path.isdir(path):
           getfiles(path)
        else:
           print("%s %s" ,(path,os.path.splitext(basename(path))[0]))


def main():
    dir = input('enter the path:')
    #getfiles(dir)
    print ('%s'%(getphotoinfo(dir)))
    dic = json.loads('{%s}'%(getphotoinfo(dir),))
    for (k,v) in dic.items():
        print( 'dic[%s]=%s'%(k,v))


#-------------
a= datetime.datetime.now()
engine = create_engine('oracle://ouchnsys:Jw2015@202.205.161.135:1521/orcl1')


if __name__=='__main__' :
     main()
