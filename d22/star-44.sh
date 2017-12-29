#!/bin/bash

declare -A grid

# states: 0=infected 1=flagged 2=empty 3=weakened
y=0
while read line; do
  for((x=0;x<${#line};x++)); do
    [[ "${line:x:1}" == "#" ]] && grid["$x:$y"]=0
  done
  ((y++))
done

((x/=2, y/=2))
dir=0
j=0
for((i=0; i<10000000; i++)); do
  [[ $((i % 10000)) -eq 0 ]] && echo -e "i: $i\tj: d: $dir\t$j\tx: $x\ty: $y\tg: ${grid[$x:$y]}\ts: ${#grid[@]}\t\t"

  s=$(((${grid[$x:$y]-2}+1)%4))
  grid[$x:$y]=$s
  [[ s -eq 0 ]] && ((j++))
  ((dir=(dir+s)%4))
  case "$dir" in 0) ((y--)) ;; 1) ((x++)) ;; 2) ((y++)) ;; 3) ((x--)) ;; esac
done
echo -e "j: $j\tx: $x\ty: $y\ts: ${#grid[@]}\t"
