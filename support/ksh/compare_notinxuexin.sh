# right include  only in the xuexin
echo 'only in xuexin'
join -1 1 -2 1 -t "," -o 1.1 2.1 1.3 18-5-xuexin.csv 18-5-ouchn.csv -a 1 |awk -F, -v OFS=',' '{if($2==""){print $0}}'|wc -l 
# left  include 'only in the ouchn 
echo 'only in ouchn'
join -1 1 -2 1 -t "," -o 1.1 2.1 2.2 18-5-xuexin.csv 18-5-ouchn.csv -a 2 |awk -F, -v OFS=',' '{if($1=="")  {print $0}}'|wc -l

#join -1 1 -2 1 -t "," -o 1.1 2.1 2.2 18-5-xuexin.csv 18-5-ouchn.csv -a 2 |awk -F, -v OFS=',' '{if(($1=="") && ($3=="")) {print $0}}'
