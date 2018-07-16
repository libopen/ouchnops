echo "begin check"
for file in *log
do
 if ! grep -q "Rows successfully loaded"  "$file" ; then 
      echo "$file loaded fail"
     
 
 fi
done

