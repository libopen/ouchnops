start=$(date +%s.%N)


unzip spy/spy183.zip -d spy/

awk -F, '{if (( $2~/^511/ || $2~/^321/ || $2~/^320/ ) ) {print $0>"spy/eas_spy_openspyleacen_temp.dat"}}' spy/spy_openspylea.csv 
awk -F, '{if (( $2~/^511/ || $2~/^321/ || $2~/^320/ ) ) {print $0>"spy/eas_spy_openspysegment_temp.dat"}}' spy/spy_openspyseg.csv 
cd spy
cat eas_spy_openspycenter_temp.ctl  spy_openspycen.csv          >exec_openspycenter_temp.ctl
cat eas_spy_openspyleacen_temp.ctl  spy_openspyleacen_temp.dat  >exec_openspyleacen_temp.ctl
cat eas_spy_openspysegment_temp.ctl spy_openspysegment_temp.dat >exec_openspysegment_temp.ctl
cat eas_spy_basicinfo_temp.ctl      spy_basicinfo.csv           >exec_basicinfo_temp.ctl
zip spy.zip exec*.ctl
read -s -n1 -p "Press any key to continue ... "
scp spy.zip libin@202.205.161.135:/backup/ftpdata/
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


