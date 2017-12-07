#!/bin/bash

input=$1

root=$(egrep -o '[a-z]+' $input | sort | uniq -u)

cat $input | sed -e 's/[,()>-]//g' | {
  declare -A weight children
  result=0

  calcTreeWeight() {
    local node=$1 child
    local w=0 w0=-1 w1=-1 wc
    local c0 c1

    for child in ${children[$node]} ; do
      calcTreeWeight $child
      local wc=$result
      if [[ $w0 -lt 0 ]]; then
        w0=$wc
        c0=$child
      else
        if [[ $w1 -lt 0 ]]; then
          if [[ $wc -ne $w0 ]]; then
            w1=$wc
            c1=$child
          fi
        else
          if [[ $wc -eq $w0 ]]; then
            echo "$c1 is unbalanced: $w1 instead of $w0, weight should be $((${weight[$c1]} + $w0 - $w1))"
          else
            echo "$c0 is unbalanced: $w0 instead of $w1, weight should be $((${weight[$c0]} + $w1 - $w0))"
          fi
          exit
        fi
      fi
      ((w+=wc))
    done
    if [[ $w1 -ge 0 ]]; then
      echo "$c1 is unbalanced: $w1 instead of $w0, weight should be $((${weight[$c1]} + $w0 - $w1))"
      exit
    else
      result=$((weight[$node] + w))
    fi
  }

  while read n w c ; do
    weight[$n]=$w
    children[$n]=$c
  done
  calcTreeWeight $root
}
