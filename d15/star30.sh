#!/bin/bash

generate() {
  v=$1
  m=$2
  d=$3
  while true; do
    ((v=(v*m)%2147483647))
    [[ $((v % d)) -eq 0 ]] && echo $((v % 65536))
  done
}

identical() {
  exec {FD1}<$1
  exec {FD2}<$2

  while read -u ${FD1} line1 && read -u ${FD2} line2; do
    [[ "$line1" == "$line2" ]] && echo $line1
  done

  exec {FD2}<&-
  exec {FD1}<&-
}

generate 591 16807 4 | head -n 5000000 > generator-a.out&
generate 393 48271 8 | head -n 5000000 > generator-b.out&

wait

identical generator-a.out generator-b.out | wc -l
