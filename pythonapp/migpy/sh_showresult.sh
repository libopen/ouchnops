#!/bin/bash

function loop(){
for i in "$1"/*
do
   if [ -d "$i" ]; then
          loop "$i"
   else
      local path=$1"/"$i
      if [ ${i##*.} = ctl ];then
          echo $path
          name=${i##*/}
          base=${name%.ctl}
          echo ${base}
          find $SPATH -type f -name "${base}.log"|wc -l
      fi
   fi
   done
}
loop "$PWD"

find /home/libin/ -iname '*log'|xargs grep -e "Rows successfully loaded" -e" Row successfully loaded"

