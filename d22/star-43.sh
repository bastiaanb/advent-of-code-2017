#!/bin/bash

declare -A grid

plot() {
  echo -n "$(tput cup $2 $1)$3"
}

y=0
clear
while read line; do
  echo $line
  for((x=0;x<${#line};x++)); do
    if [[ "${line:x:1}" == "#" ]]; then
      grid["$x:$y"]="#"
    fi
    done
  ((y++))
done

bottom="$(tput cup $y 0)"

dir=up
x=$((x/2))
y=$((y/2))

j=0
for((i=0; i<10000; i++)); do
  echo -e "$bottom i: $i\tj: $j\tx: $x\ty: $y"
  cell="${grid[$x:$y]}"
  if [[ "$cell" == "#" ]]; then
    case "$dir" in
         up) dir=right ;;
      right) dir=down  ;;
       down) dir=left  ;;
       left) dir=up    ;;
    esac
    unset "grid[$x:$y]"
    plot $x $y ' '
  else
    case "$dir" in
         up) dir=left  ;;
      right) dir=up    ;;
       down) dir=right ;;
       left) dir=down  ;;
    esac
    ((j++))
    grid[$x:$y]="#"
    plot $x $y '#'
  fi

  case "$dir" in
       up) ((y--)) ;;
    right) ((x++)) ;;
     down) ((y++)) ;;
     left) ((x--)) ;;
  esac
done
echo -e "$bottom i: $i\tj: $j\tx: $x\ty: $y"
