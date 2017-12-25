#!/bin/bash

#skip=3
skip=359
c=0
zero=0
for((i=1;i<=50000000;i++)) do
  c=$(((c+skip)%i))
  if [[ $c -eq 0 ]]; then
    zero=$i
    echo "zero $i"
  fi
  ((c++))
  [[ $((i%100000)) -eq 0 ]] && echo $i $zero
done

echo $zero
