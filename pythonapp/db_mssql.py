from sqlalchemy import create_engine
#link mssql use pymssql must install freetds and set ln -s /usr/local/lib/libdbd.so.5 /usr/lib64/libdb.so.5
#http://blog.csdn.net/mmx/article/detail/48064109
db=create_engine('mssql+pymssql://sa:abc123@10.96.142.103:1433/cps1')
resultProxy = db.execute('select * from xxdmb')

result=resultProxy.fetchall()
resultProxy.close()
for row in result:
    print(row[0])




