#!/bin/bash

declare -a ring
size=256

for((i=0;i < size; i++)); do
  ring[$i]=$i
done

pos=0
skipsize=0

for l in $(tr ',' ' '); do
  echo "$skipsize, $pos, $l: ${ring[*]}"

  # rev pos l
  for((f=pos,b=pos+l-1; f < b; f++, b--)); do
    t=${ring[$((b % size))]}
    ring[$((b % size))]=${ring[$((f % size))]}
    ring[$((f % size))]=$t
  done
  ((pos+=l+skipsize))
  ((skipsize++))
done

echo "$skipsize, $pos, $l: ${ring[*]}"
echo $((${ring[0]} * ${ring[1]}))
