#!/bin/bash

input="$1$1"
len=${#1}
half=$((len / 2))
count=0
echo $input
for ((i=0;i < len; i++)) ; do
  c=${input:$i:1}
  if [[ $c == "${input:$((i+half)):1}" ]] ; then
    ((count=count + c))
    echo $c $count
  fi
done

echo $count
