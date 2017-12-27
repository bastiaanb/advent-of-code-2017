#!/bin/bash

maze=()
i=0
size=128
ls=$((size+2))

maze[$((i++))]='|'
for((j=0; j<size; j++)) do
  maze[$((i++))]='-'
done
maze[$((i++))]='|'

while read line; do
  maze[$((i++))]='|'
  for((j=0; j < ${#line}; j++)) do
    maze[$((i++))]=${line:$j:1}
  done
  maze[$((i++))]='|'
done

maze[$((i++))]='|'
for((j=0; j < size; j++)) do
  maze[$((i++))]='-'
done
maze[$((i++))]='|'

clear
echo "${maze[@]}" | sed -e 's/ //g' -e 's/||/|\n|/g'

area=0

stack=()
sp=0

pos=$((ls+1))
while [[ ${maze[$pos]} != '-' ]]; do
  if [[ ${maze[$pos]} == '#' ]]; then
    ((area++))
    echo "$(tput cup 0 $((ls+2)))$(tput setab 0)areas: $area$(tput setab $((1+area%7)))"
    stack[$((sp++))]=$pos
    while [[ $sp -gt 0 ]]; do
      p=${stack[$((--sp))]}
      if [[ ${maze[$p]} == '#' ]]; then
        maze[$p]='X'
        echo -n "$(tput cup $((p/ls)) $((p%ls))) "
        stack[$((sp++))]=$((p-ls))
        stack[$((sp++))]=$((p+ls))
        stack[$((sp++))]=$((p-1))
        stack[$((sp++))]=$((p+1))
      fi
    done
  fi
  ((pos++))
done
