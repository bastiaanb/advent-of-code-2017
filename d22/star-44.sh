#!/bin/bash

declare -A grid

plot() {
  echo -n "$(tput cup $2 $1)$3"
}

turnright() {
  case "$dir" in
       up) dir=right ;;
    right) dir=down  ;;
     down) dir=left  ;;
     left) dir=up    ;;
  esac
}

turnleft() {
  case "$dir" in
       up) dir=left  ;;
    right) dir=up    ;;
     down) dir=right ;;
     left) dir=down  ;;
  esac
}

reverse() {
  case "$dir" in
       up) dir=down  ;;
    right) dir=left  ;;
     down) dir=up    ;;
     left) dir=right ;;
  esac
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
for((i=0; i<10000000; i++)); do
  [[ $((i % 10000)) -eq 0 ]] && echo -e "i: $i\tj: $j\tx: $x\ty: $y"
#  sleep 1
  case "${grid[$x:$y]}" in
    '#')
      turnright
      grid[$x:$y]="F"
#      plot $x $y 'F'
      ;;
    'W')
      ((j++))
      grid[$x:$y]="#"
#      plot $x $y '#'
      ;;
    'F')
      reverse
      unset "grid[$x:$y]"
#      plot $x $y ' '
      ;;
    '')
      turnleft
      grid[$x:$y]="W"
#      plot $x $y 'W'
      ;;
  esac

  case "$dir" in
       up) ((y--)) ;;
    right) ((x++)) ;;
     down) ((y++)) ;;
     left) ((x--)) ;;
  esac
done
echo -e "i: $i\tj: $j\tx: $x\ty: $y"
