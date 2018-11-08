import sys
import os.path
import time             


def main():
    if 1==len(sys.argv):
       print ('enter the uid pwd rootpath ')
       return
    else:
       rootpath= sys.argv[3]
       uid = sys.argv[1]
       pwd = sys.argv[2]
       var =1 
       while var ==1 :
             ctlname=input("enter a cltname:")
             ctlpath = '%s/%s.ctl'%(rootpath,ctlname)
                                                   
             csvpath = '%s/%s.dat'%(rootpath,ctlname)
                                                   
             if os.path.isfile(ctlpath):
                if  os.path.isfile(csvpath):
                    ts = time.time()
                    ctlfile ="%s/%s control=%s "% (uid,pwd,ctlpath)
                    impcmd = "sqlldr %s"%(ctlfile,)
                    os.system(impcmd)
                    print('took %s minutes '%((time.time()-ts)/60,))
                else:
                    print('dat: %s is not exist'%(csvpath,))
             else:
                  print('ctl: %s   is not exist'%(ctlpath,))

if __name__ == "__main__":
     main()
