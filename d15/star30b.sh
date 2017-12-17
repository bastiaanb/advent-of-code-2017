#!/bin/bash

count=0
a=591
b=393
for((i=0;i<5000000;i++)); do
  while true; do ((a=(a*16807)%2147483647)); [[ $((a & 3)) -eq 0 ]] && break; done
  while true; do ((b=(b*48271)%2147483647)); [[ $((b & 7)) -eq 0 ]] && break; done
  [[ $(((a - b) & 65535)) -eq 0 ]] && ((count++))
done

echo $count
