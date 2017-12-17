#!/bin/bash

generate() {
  for ((v=${1},m=${2}; ; v=(v*m)%2147483647)) do echo $((v & 65535)); done
}

paste <(generate 591 16807) <(generate 393 48271) | head -n 40000000 | egrep -c '^([0-9]+)\s\1$' 
