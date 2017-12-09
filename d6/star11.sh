#!/bin/bash

declare -A seen
declare -a s

read -r -a s
size=${#s[@]}

while true; do
  state="${s[*]}"
  echo "$state"
  if [[ ${seen[$state]} -eq 1 ]] ; then
    echo "seen state $state"
    echo "count ${#seen[@]}"
    exit
  fi
  seen["${s[@]}"]=1

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
