#!/bin/bash

d="abcdefghijklmnop"

read input

swap() {
  if [[ $1 -lt $2 ]]; then
    f=$1
    t=$2
  else
    f=$2
    t=$1
  fi
  d="${d:0:f}${d:t:1}${d:f+1:t-f-1}${d:f:1}${d:t+1}"
}

pair() {
  for ((i=0;i<${#d};i++)) do
    [[ ${d:i:1} == "$1" ]] && break;
  done
  for ((j=0;j<${#d};j++)) do
    [[ ${d:j:1} == "$2" ]] && break;
  done
  swap $i $j
}

tr ',' '\n' <<< $input | {
  while read ins; do
    o=${ins:1}
    case ${ins:0:1} in
      s) d="${d: -o}${d:0:${#d}-o}" ;;
      x) swap ${o%/*} ${o#*/} ;;
      p) pair ${o%/*} ${o#*/} ;;
    esac
    echo $d
  done
}
