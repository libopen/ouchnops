import pandas as pd
import redis
import sys
import os.path
import json

# for this app is use bcp for export data from mssql so  only use in windows 
# scope 1 is center 2  is segment 


"""
  *****************************
  this function is use to deal with every job of export 
  *****************************
"""
# --------------------begin --------------------------
def main():    
    rootpath='/home/libin/python/'  
    if 1!=len(sys.argv):
       rootpath=sys.argv[1]
    re = redis.Redis(host='10.96.142.109',port=6380,db=3)
    #first flush db
    re.flushdb()
    if os.path.isfile(rootpath+'datamigrate.xlsx'):
       xls = pd.ExcelFile(rootpath+'datamigrate.xlsx')
       sheet1 = xls.parse('sqlldr')
       for index ,row in sheet1.iterrows():
             re.hmset('ctlpath',{row['ctlfile']:row['ctlpath']})       
             re.hmset('ctldb',{row['ctlfile']:row['db']})
    

       sheet2 = xls.parse('oracledb')
       for index ,row in sheet2.iterrows():
           skey = row['dbname']
           re.hmset(skey,{'uid':row['uid'],'pwd':row['pwd'],'dbip':row['dbip'],'servicename':row['servicename']})
       print(" config is finished")
    else:
       pirnt("datamigrate.xlsx config file is not exist")

if __name__=="__main__":
     main()
