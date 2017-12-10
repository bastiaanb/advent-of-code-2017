#!/bin/bash

declare -a ring
size=256

for((i=0;i < size; i++)); do
  ring[$i]=$i
done

read line
declare -a input
for((i=0; i < ${#line}; i++)); do
  input+=($(printf '%d' "'${line:$i:1}"))
done
input+=(17 31 73 47 23)

pos=0
skipsize=0

for((round=1; round <= 64; round++)); do
  for l in "${input[@]}"; do
    for((f=pos,b=pos+l-1; f < b; f++, b--)); do
      t=${ring[$((b % size))]}
      ring[$((b % size))]=${ring[$((f % size))]}
      ring[$((f % size))]=$t
    done
    ((pos+=l+skipsize))
    ((skipsize++))
  done
done

for((i=0; i < size; )); do
  v=0
  for((j=0; j < 16; i++, j++)); do
    ((v^=${ring[$i]}))
  done
  printf "%02x" $v
done 
