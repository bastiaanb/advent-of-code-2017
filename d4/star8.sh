#!/bin/bash

c=0
while read line ; do
  dup=$({
    for w in $line ; do
      grep -o . <<< $w | sort |tr -d "\n"
      echo
    done
  } | sort | uniq -d)

  [[ -z $dup ]] && ((c++))
done
echo $c
