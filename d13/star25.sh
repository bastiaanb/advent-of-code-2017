#!/bin/bash

sed 's/[:]//g' | {
  s=0
  while read depth range; do
    [[ $((depth % ((range - 1)*2) )) -eq 0 ]] && ((s+=depth*range))
  done
  echo $s
}
