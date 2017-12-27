#!/bin/bash

#key=hxtvlmkl
key=flqrgnkx

hasher=../d10/star20.sh

{
  for((i=0; i < 128; i++)); do
    echo $i > /dev/stderr
    $hasher <<< "$key-$i"
  done
} | sed -e 's/0/..../g' \
        -e 's/1/...#/g' \
        -e 's/2/..#./g' \
        -e 's/3/..##/g' \
        -e 's/4/.#../g' \
        -e 's/5/.#.#/g' \
        -e 's/6/.##./g' \
        -e 's/7/.###/g' \
        -e 's/8/#.../g' \
        -e 's/9/#..#/g' \
        -e 's/a/#.#./g' \
        -e 's/b/#.##/g' \
        -e 's/c/##../g' \
        -e 's/d/##.#/g' \
        -e 's/e/###./g' \
        -e 's/f/####/g'
