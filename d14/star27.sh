#!/bin/bash

key=hxtvlmkl

hasher=../d10/star20.sh

sumall() {
  local count=0
  while read line; do
    ((count+=line))
  done
  echo $count
}

{
  for((i=0; i < 128; i++)); do
    $hasher <<< "$key-$i"
  done
} | tr '0123456789abcdef' '0112122312232334' | grep -o . | sumall
