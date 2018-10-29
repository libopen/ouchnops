join -1 1 -2 1 -t "," -o 1.1 2.1 1.3 18-5-xuexin.csv 18-5-ouchn.csv -a 1 |awk -F, -v OFS=',' '{if($2==""){print $0}}'
