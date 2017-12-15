#!/bin/bash

a=591
b=393
c=0
for((i=0; i < 40000000; i++)); do
  [[ $((i%10000)) -eq 0 ]] && echo $i
  ((a=(a*16807)%2147483647))
  ((b=(b*48271)%2147483647))
  if [[ $(((a - b) % 65536)) -eq 0 ]]; then
     echo "found $c: $a $b"
    ((c++))
  fi
done
echo $c
