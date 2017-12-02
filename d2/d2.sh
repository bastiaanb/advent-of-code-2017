#!/bin/bash

checksum=0
while read line ; do
  max=$(tr ' ' '\n' <<< $line | sort -n | tail -1)
  min=$(tr ' ' '\n' <<< $line | sort -n -r | tail -1)
  checksum=$((checksum + max - min))
  echo $max $min $checksum
done
echo $checksum
