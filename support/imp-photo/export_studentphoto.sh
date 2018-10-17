start=$(date +%s.%N)



cat cps_studentphoto.ctl cps_studentphoto.csv >exec_studentphoto.ctl
dur=$(echo "$(date +%s.%N) - $start "| bc)
printf "it took %.6f seconds " $dur


