#!/bin/bash

declare -A seen
declare -a s

read -r -a s
size=${#s[@]}

c=0
while true; do
  state="${s[*]}"
  [[ ${seen[$state]} -gt 0 ]] && break

  seen[$state]=$((++c))

  v=0
  j=0
  for((i=0; i < size; i++)) do
    if [[ ${s[$i]} -gt $v ]]; then
      v=${s[$i]}
      j=$i
    fi
  done
  s[$j]=0
  while [[ $v -gt 0 ]]; do
    ((j=(j+1) % size ))
    ((s[$j]++))
    ((v--))
  done
done

echo "seen state $state"
echo "count $c"
echo "cycle $((c - ${seen[$state]}))"
