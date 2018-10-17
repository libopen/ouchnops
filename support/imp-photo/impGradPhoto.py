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

            

def getfiles(rootDir,wr):
    def getphotoinfo(filename):
        # get student information from the stufile.txt (this is export by db)
        #查询带有中文编码，要先解码，再编码为中文作为查询条件:
        dict={}
        reader=csv.DictReader(open(filename,'r',encoding='gb2312'))
        for line in reader:
            dict[line['IDNUMBER']]=line
        return dict
    
    def getPhotoInfo(idkey,dicts):
          if idkey not in dicts:
             return None
          else:
             dics=dict[idkey]
             studentid=dics['STUDENTID']
             
             filepath='Files/GraduatePIC/%s/%s/%s/'%(dics['STUDENTTYPE'],dics['PROFESSIONALLEVEL'],dics['BATCHCODE'])
             return studentid,filepath
            
         #begin 
    dict=getphotoinfo('stuinfo.txt')
    for lists in os.listdir(rootDir):
        path = os.path.join(rootDir,lists)
        if os.path.isdir(path):
             getfiles(path,wr)
        else:
           try:
              csvlist=[''  for x in range(8)]
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
              idnumber = os.path.splitext(basename(filepath))[0].upper()
              csvlist[0]=idnumber
              filesize = os.stat(path).st_size
              csvlist[6]=filesize
              csvlist[7]='end'
              if idnumber not in dict:
                  #if  photolist is None:
                  #同样存储中unicode要存储为中文编码也要先解码再编码
                  #wr.writerow((''.join(filename),'','','','imp',idnumber))
                  print("{} not find ".format(idnumber))
                  logger.info('%s not found'%(idnumber))
              else :
                   
                   studentid,stufilepath=getPhotoInfo(idnumber,dict)
                   csvlist[1]=studentid
                   csvlist[2]='wh18014232'
                   csvlist[3]=basename(path)
                   csvlist[4]=stufilepath
                   csvlist[5]='2'
                   #targetPathRoot is globa variable
                   targetPath = os.path.join(targetPathRoot,stufilepath)
                   #print(targetPath)
                   if not os.path.exists(targetPath):
                      os.makedirs(targetPath)
                   shutil.copy(path,os.path.join(targetPath,basename(path)))
                   dst_file = os.path.join(targetPath,basename(path))
                   #not rename filename
                   #new_dst_file = os.path.join(targetPath,photo['newphotoname'])
                   #os.rename(dst_file,new_dst_file)
                   #print('%s:%s'%(idnumber,getphotoinfo(''.join(idnumber))))  
                   wr.writerow(csvlist)
           except:
                   fd = os.open(path,os.O_RDWR|os.O_CREAT)
                   info = os.fstat(fd)
                   print(info.st_ino)  
                   logger.debug('file index number:%s%s'%(info.st_ino,path))
                   break
         


def main():
    global targetPathRoot
    if 1==len(sys.argv):
       print('enter the file path')
       return
    else :
       #dir = input('enter the path:')
       dir = sys.argv[1]
       targetPathRoot='./'
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
