#!/bin/bash

checksum=0
while read line ; do
  for i in $line ; do
    for j in $line ; do
      if [[ $i -ne $j ]] && [[ $((j % i)) -eq 0 ]] ; then
        ((checksum+=j/i))
        break
      fi
    done
  done
done
echo $checksum
