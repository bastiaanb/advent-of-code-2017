#!/bin/bash

sed 's/[:]//g' | {
  while read depth range; do
#    [[ $((depth % ((range - 1)*2) )) -eq 0 ]] && ((s+=depth*range))
    m=$(((range - 1)*2))
    echo -e "$((m/2))\t$(((depth % m)/2))"
  done
}
