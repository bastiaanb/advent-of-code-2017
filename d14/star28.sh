#!/bin/bash

cat <(printf '%.0s-' {1..128}; echo) - <(printf '%.0s-' {1..128}; echo) | {
  maze=()
  i=0
  ls=130

  while read line; do
    maze[$((i++))]='|'
    for((j=0; j < ${#line}; j++)) do
      maze[$((i++))]=${line:$j:1}
    done
    maze[$((i++))]='|'
  done

  clear
  echo "${maze[@]}" | sed -e 's/ //g' -e 's/||/|\n|/g'

  area=0
  for pos in "${!maze[@]}"; do
    if [[ ${maze[$pos]} == '#' ]]; then
      ((area++))
      echo "$(tput cup 0 $((ls+2)))$(tput setab 0)areas: $area$(tput setab $((1+area%7)))"
      stack=($pos)
      sp=1
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
  done
}
