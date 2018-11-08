import datetime
import time
from sqlalchemy import Table,MetaData,Column,ForeignKey,Integer,String,Date,text,create_engine,update
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import sessionmaker
import redis
import os

os.environ['NLS_LANG']='AMERICAN_AMERICA.ZHS16GBK'
redis = redis.Redis(host='10.96.142.109',port=6380,db=4)

engine = create_engine('oracle://ouchnsys:Jw2015@202.205.161.137:1521/orcl1')
tables =['eas_exmm_signup']
metadata = MetaData()
metadata.reflect(engine,only=tables)
Base = automap_base(metadata=metadata)
Base.prepare()

signup  =Base.classes.eas_exmm_signup


def update_signup_coursename(courseid):
    ts = time.time()
    coursename = str(redis.get(courseid).decode('gb2312'))
    print(coursename)
    conn = engine.connect()
    stmt = update(signup).\
                  where(signup.courseid==courseid).\
                  values(coursename=coursename)
    conn.execute(stmt)
    print('took %s minutes' % ((time.time()-ts)/60,))             




if __name__=="__main__":
    update_signup_coursename('01818')
