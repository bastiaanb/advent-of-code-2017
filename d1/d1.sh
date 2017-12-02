#!/bin/bash

input="$1${1:0:1}"
count=0
echo $input
for ((i=0;i < ${#input} -1; i++)) ; do
  c=${input:$i:1}
  if [[ $c == "${input:$((i+1)):1}" ]] ; then
    ((count=count + c))
    echo $c $count
  fi
done
