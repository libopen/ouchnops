# -*- coding: utf-8 -*-
import os
import sys
from os.path import basename
import datetime
from sqlalchemy import create_engine
import json
import csv
import time
import shutil
import hashlib
import logging
import logging.handlers;

def getphotoinfo(filename):
    ts = time.time()
    photoinfo=[]
    #print(isinstance(filename,unicode))  
    sql = 'select a.studentid,a.batchcode,a.professionallevel,a.studenttype from eas_schroll_student a inner join eas_schroll_studentbasicinfo b on a.studentid=b.studentid where b.idnumber=:idnumber'
    #查询带有中文编码，要先解码，再编码为中文作为查询条件:
    #result =engine.execute(sql,idnumber=filename.encode('utf-8','surrogateescape').decode('gb2312'))
    result =engine.execute(sql,idnumber=filename)
    for row in result:
        filepath='Files/RecruitPIC/%s/%s/%s/'%(row[3],row[2],row[1])
        #print(filepath)
        info = dict()
        info['studentid']=row[0]
        info['filepath']=filepath
        info['idnumber']=filename.encode('utf-8')
        #new photoname and md5 
        info['newphotoname']=hashlib.md5(filename.encode('utf-8')).hexdigest()+'.jpg'
        photoinfo.append(info)
    print('%r: took  %s seconds  '%(filename, time.time()-ts))
    return photoinfo
            

def getfiles(rootDir,wr):
                     
             for lists in os.listdir(rootDir):
                  path = os.path.join(rootDir,lists)
                  if os.path.isdir(path):
                      getfiles(path,wr)
                  else:
                      try:
                          #print(type(path))
                          #print(chardet.detect(path)['encoding'])
                          filepath = path.encode('utf-8','surrogateescape').decode('gb2312')
                          #filepath=path    
                                       
                          #print(chardet.detect(os.path.splitext(basename(filepath))[0]))
                          #正常情况下打印结果，会看到unicode编码而看不到中文
                          #print("%r %s" %(path,os.path.splitext(basename(filepath))[0].encode('utf-8','surrogateescape').decode('gb2312')))
                          #如果要看中文输出要先解码码再编码
                          #print(filepath.encode('utf-8','surrogateescape').decode('gb2312'))
                          filename = basename(filepath)
                          idnumber = os.path.splitext(basename(filepath))[0]
                          filesize = os.stat(path).st_size
                          photolist = getphotoinfo(''.join(idnumber))
                          if not photolist:
                              #同样存储中unicode要存储为中文编码也要先解码再编码
                              wr.writerow((''.join(filename),'','','','imp',idnumber))
                          else :
                              for photo in photolist:
                                  try:
                                     targetPath = os.path.join(targetPathRoot,photo['filepath'])
                                     print(targetPath)
                                     if not os.path.exists(targetPath):
                                        os.makedirs(targetPath)
                                     shutil.copy(path,os.path.join(targetPath,basename(path)))
                                     dst_file = os.path.join(targetPath,basename(path))
                                     new_dst_file = os.path.join(targetPath,photo['newphotoname'])
                                     os.rename(dst_file,new_dst_file)
                                     #print('%s:%s'%(idnumber,getphotoinfo(''.join(idnumber))))  
                                     wr.writerow((photo['newphotoname'],photo['studentid'],photo['filepath'],filesize,'imp',idnumber))
                                  except:
                                      print('except')
                                  finally:
                                      #print('finally')
                                       pass
                      except:
                             fd = os.open(path,os.O_RDWR|os.O_CREAT)
                             info = os.fstat(fd)
                             print(info.st_ino)  
                             logger.debug('file index number:%s'%(info.st_ino,))
         


def main():
    global targetPathRoot
    if 1==len(sys.argv):
       print('enter the file path')
       return
    else :
       #dir = input('enter the path:')
       dir = sys.argv[1]
       if 3==len(sys.argv):
          targetPathRoot=sys.argv[2]

    #print(targetPath)
      
    try:       
       with open('cps_studentphoto.csv','w',newline='',encoding='utf-8') as csvfile:
       #with open('imp.csv','w') as csvfile:
             wr = csv.writer(csvfile,quoting=csv.QUOTE_NONE)
             getfiles(dir,wr)
    finally:
       csvfile.close()


#-------------
os.environ['NLS_LANG'] = 'AMERICAN_AMERICA.ZHS16GBK'
a= datetime.datetime.now()
engine = create_engine('oracle://ouchnsys:Jw2015@202.205.161.135:1521/orcl1')
targetPathRoot=os.path.dirname(os.path.realpath(__file__))
LOG_FILE=os.path.join(targetPathRoot,'impPhoto.log')
handler=logging.handlers.RotatingFileHandler(LOG_FILE,maxBytes=1023*1024,backupCount=5)
fmt='%(asctime)s - %(filename)s:%(lineno)s - %(name)s - %(message)s'
formatter=logging.Formatter(fmt)
handler.setFormatter(formatter)
logger=logging.getLogger('imp')
logger.addHandler(handler)
logger.setLevel(logging.DEBUG)
if __name__=='__main__' :
     main()
