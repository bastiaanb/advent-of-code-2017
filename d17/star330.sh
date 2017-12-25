#!/bin/bash

skip=359
declare -A ring

ring[0]=0
c=0
for((i=1;i<=5000000;i++)) do
  for((j=0;j<skip;j++)) do
    c=${ring[$c]}
  done
  ring[$i]=${ring[$c]}
  ring[$c]=$i
  c=$i
  [[ $((i%1000)) -eq 0 ]] && echo $i ${ring[$i]}
done

echo ${ring[0]}
