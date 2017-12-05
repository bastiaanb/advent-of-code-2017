#!/bin/bash

declare -a program

l=0;
while read line; do
  program[$l]=$line
  ((l++))
done

pc=0
clock=0
while [[ $pc -ge 0 ]] && [[ $pc -lt l ]]; do
  s=${program[$pc]}
  if [[ $s -ge 3 ]]; then
    ((program[$pc]--))
  else
    ((program[$pc]++))
  fi
  ((pc+=s, clock++))
  [[ $((clock % 10000)) -eq 0 ]] && echo $clock, $pc
done

echo $clock, $pc
