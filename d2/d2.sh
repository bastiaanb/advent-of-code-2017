#!/bin/bash

checksum=0
while read line ; do
  max=$(tr ' ' '\n' <<< $line | sort -n | tail -1)
  min=$(tr ' ' '\n' <<< $line | sort -n | head -1)
  ((checksum += max - min))
done
echo $checksum
