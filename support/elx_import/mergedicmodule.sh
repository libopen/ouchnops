cat $1 |sed 's/\r//g'|awk -F,  '{ if(NR!=1) {print "\042"$2"\042:\042"$1"\042,"}}'|awk '{printf("%s",$0);next} {print $0}'>dicmodule.txt

