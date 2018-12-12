#cat export/data_elc*csv 
#if [[ -e $ff ]];then
    cat export/data_elc*.csv > export/total_elc.csv
    #sed 's/\r/,end/g' -i export/total_elc.csv
    cat export/ctl_elc.ctl export/total_elc.csv > export/exec_elc.ctl
 #else
 #   echo "data_elc*csv is not exists"
 #fi


# if [[ -e export/data_signup*csv ]];then
     cat export/data_signup*.csv > export/total_signup.csv
     #sed 's/\r/,end/g' -i export/total_signup.csv
     cat export/ctl_signup.ctl export/total_signup.csv > export/exec_signup.ctl
# else
#    echo "data_signup*csv is not exists"
# fi

# if [[ -e export/data_score*csv ]];then
     cat export/data_score*.csv > export/total_score.csv
     #sed 's/\r/,end/g export/data_score.csv
     cat export/ctl_composescore.ctl export/total_score.csv > export/exec_composescore.ctl
# else
#    echo "data_score*csv is not exists"
# fi
 
#if [[ -e export/data_wks*csv ]];then
     cat export/data_wks*.csv > export/total_netexamscore.csv
     #sed 's/\r/,end/g export/data_score.csv
     cat export/ctl_netexamscore.ctl export/total_netexamscore.csv > export/exec_netexamscore.ctl
 #else
 #   echo "data_score*csv is not exists"
 #fi
 
