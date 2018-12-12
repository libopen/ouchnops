rm *.stu
for i in *;
do
  extname=`echo $i|rev|cut -d . -f 1|rev`;
  firstname=`echo $i|cut -d . -f 1`
  #echo ${i:0:3};
  # if filename begin with elc we will deal with by elc pattern and export the first column that is studentcode column. 
  if [[ (${extname:0:3} == xls) && ((${i:0:3} == elc) || (${i:0:4} == sign) || (${i:0:5} == score )) ]]
  then
     python3.5 xls2csv_Normal.py $i
     csvfile=$firstname"*.csv"
     # use cut export only studentcode 
     cut $csvfile  -d , -f 1|sort|uniq > $firstname".stu"
  fi
done
# unqi all *.stu ,move to export
cat *.stu|sort|uniq > export/studentcode.csv
sed -i '1d' export/studentcode.csv
# for studentcode.csv add the \r at the end of the every lines.
sed 's/$/,end1\r/g' -i export/studentcode.csv
cat export/ctl_studentcode.ctl export/studentcode.csv >export/exec_studentcode.ctl

