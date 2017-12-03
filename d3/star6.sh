#!/bin/bash

input=$1

declare -A memory
memory["0:0"]=1

((LX=0, LY=0))
dir=R
side=1

while true ; do
  steps=$side

  case $dir in
    R) dir=U; ((dx= 1, dy= 0         )) ;;
    U) dir=L; ((dx= 0, dy= 1, side+=1)) ;;
    L) dir=D; ((dx=-1, dy= 0         )) ;;
    D) dir=R; ((dx= 0, dy=-1, side+=1)) ;;
  esac

  for ((i=0; i < steps; i++)); do
      ((LX+=dx, LY+=dy))
      s=$((
        memory["$((LX-1)):$((LY-1))"] + memory["$((LX)):$((LY-1))"] + memory["$((LX+1)):$((LY-1))"] +
        memory["$((LX-1)):$((LY  ))"] + memory["$((LX)):$((LY  ))"] + memory["$((LX+1)):$((LY  ))"] +
        memory["$((LX-1)):$((LY+1))"] + memory["$((LX)):$((LY+1))"] + memory["$((LX+1)):$((LY+1))"]
      ))
      memory["$LX:$LY"]=$s
      echo $s
      [[ $s -gt $input ]] && exit
  done
done
