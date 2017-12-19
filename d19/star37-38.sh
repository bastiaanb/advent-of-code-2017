#!/bin/bash

maze=()
text=""

clear
IFS=''
while read line; do
  maze+=("$line")
  echo $line
done

x=1
y=0
dir=down

straight() {
  case "$dir" in
      up) ((y--)) ;;
    down) ((y++)) ;;
    left) ((x--)) ;;
    right) ((x++)) ;;
    *) echo "unknown direction $dir" && exit ;;
  esac
}

turn() {
  case "$dir" in
    up|down)
      if [[ ${maze[y]:x-1:1} == '-' ]]; then
        ((x--))
        dir=left
      elif [[ ${maze[y]:x+1:1} == '-' ]]; then
        ((x++))
        dir=right
      else
        lost
      fi
      ;;
    left|right)
      if [[ ${maze[$((y-1))]:x:1} == '|' ]]; then
        ((y--))
        dir=up
      elif [[ ${maze[$((y+1))]:x:1} == '|' ]]; then
        ((y++))
        dir=down
      else
        lost
      fi
      ;;
  esac
}

lost() {
  echo "cannot find turn at $x $y $c"
  exit
}


red="$(tput setab 1)"
yellow="$(tput setab 3)"

count=0
px=x
py=y
while true; do
  c=${maze[$y]:x:1}
  echo -n "${yellow}$(tput cup $y $x) "
  echo -n "${red}$(tput cup $py $px) "
  case "$c" in
    '+') turn ;;
    [a-zA-Z]) text+=$c; straight ;;
    '|' | '-') straight ;;
#    ' ') echo "text=$text, count=$count" && exit ;;
    ' ') sleep 3600 ;;
  esac
  ((count++))
  px=$x
  py=$y
done

# asciinema rec -t "Advent Of Code Day 19 - ASCII Art" -c "./star37.sh < input.txt" star37.json
