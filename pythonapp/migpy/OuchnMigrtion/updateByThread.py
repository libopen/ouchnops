from queue import Queue
from threading import Thread
import time
import redis
import sys
import os.path
from dbapp_signup import update_signup_coursename

class updateSignWorker(Thread):
      def __init__(self,queue):
          Thread.__init__(self)
          self.queue = queue
     
      def run(self):
          while True:
             # get the work from the queue and expand the tuple
             courseid = self.queue.get()
             print(' [x] process %s   '% (courseid,))
             update_signup_coursename(courseid)
             
             self.queue.task_done()



def main():
    if 1==len(sys.argv):
       print ('enter the target signup ..  ')
       return
    else:
       db = sys.argv[1]
       ts = time.time()
       myredis = redis.Redis(host='10.96.142.109',port=6380,db=4)
       queue=Queue()
       for x in range(6):
            worker = updateSignWorker(queue)
            # setting daemon to True will let then main thread exit even though the workers are blocking
            worker.demon = True
            worker.start()
       while 0<myredis.llen('COURSEID') :
          # create a queue to communicate with the worker threads
          courseid = str(myredis.lpop('COURSEID').decode('utf-8'))
          queue.put(courseid)
       queue.join()    
       print('took %s minutes '%((time.time()-ts)/60,))
       

if __name__ == "__main__":
     main()
