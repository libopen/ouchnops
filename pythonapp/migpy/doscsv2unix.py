import time
import redis
import sys
import os.path



def main():
    if 1==len(sys.argv):
       print ('enter the target db .. db1 or db2 or db3 ')
       return
    else:
       rootpath='/home/libin/data/'
       db = sys.argv[1]
       ts = time.time()
       myredis = redis.Redis(host='10.96.142.109',port=6380,db=3)
       curdb = myredis.hgetall(sys.argv[1])
       if 0<len(curdb.keys()) :
          # create a queue to communicate with the worker threads
          uid = str(curdb[b'uid'].decode('utf-8'))
          pwd = str(curdb[b'pwd'].decode('utf-8'))
          ctllist = myredis.hgetall('ctldb')
          pathlist = myredis.hgetall('ctlpath')
          for (key,val)  in ctllist.items():
              if db==str(val.decode('utf-8')):
                  csvpath = '%s%s/%s.dat'%(rootpath,str(pathlist[key].decode('utf-8'))\
                                                   ,str(key.decode('utf-8')))
                  if  os.path.isfile(csvpath):
                      impcmd = "dos2unix %s"%(csvpath,)
                      os.system(impcmd)
                  else:
                      print('%s\'s dat is not exist'%(csvpath,))
                   
                         
       else:
          print(' %s is not in config'%(db,))  
       print('took %s minutes '%((time.time()-ts)/60,))

if __name__ == "__main__":
     main()
