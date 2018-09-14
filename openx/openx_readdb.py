import xlrd,csv ,os,sys,re
class clstb:
    def __init__(self,tbname):
        self.tbname=tbname
        self.collist={}
    
     
wb=xlrd.open_workbook('d:\openx.xls')
sh=wb.sheet_by_index(0)
#print(sh.nrows)
tblist=[]
# read top 3 line confirm it is a single table description.
curtb= None
itb=1
for i in range(0,sh.nrows):
    rowvalue=sh.row_values(i)
    #print(rowvalue)
    #print(len(rowvalue[0]))
    # 文件格式  6列
    p = re.compile('<\S+>')
    if rowvalue[0]!="": # 说明不是空行 可能是
        if len(p.findall(rowvalue[0]))>0:
            a=re.search('<\S+>',rowvalue[0]).group()
            #print(str(itb)+a)
            newtb=clstb(a.replace('<','').replace('>',''))
            curtb=newtb
            itb=itb+1
        else:
            tb_key=rowvalue[0]
            tb_val=rowvalue[5]
            if curtb!=None and tb_key!="代码":
                
               curtb.collist[tb_key]=tb_val
        
    else :
        if curtb!=None:        
           tblist.append(curtb)
           curtb=None
        
j=1
for item in tblist:
    #print(str(j)+item.tbname)
    j=j+1
    for col in item.collist:
        if item.collist[col]!="" :
           print("objDict.add \"{}-{}\",\"{}\"".format(item.tbname,col,item.collist[col]))
