#!/bin/bash

generate() {
  for ((v=${1}, m=$2, d=$((${3}-1)), c=2147483647; ; v=(v*m)%c)) do
    [[ $((v & d)) -eq 0 ]] && echo $((v & 65535))
  done
}

paste <(generate 591 16807 4) <(generate 393 48271 8) | head -n 5000000 | egrep -c '^([0-9]+)\s\1$'
