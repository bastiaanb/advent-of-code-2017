#!/bin/bash

c=0
while read line ; do
  [[ -z $(tr ' ' '\n' <<< $line | sort | uniq -d) ]] && ((c++))
done
echo $c
