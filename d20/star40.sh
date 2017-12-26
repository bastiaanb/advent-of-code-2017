#!/bin/bash

tr  '[a-z=<>,]' ' ' | {
  declare -a px py pz vx vy vz ax ay az
  declare -A live
  c=0
  while read px[$c] py[$c] pz[$c] vx[$c] vy[$c] vz[$c] ax[$c] ay[$c] az[$c]; do
    live[$c]=1
    ((c++))
  done

  declare -A cols
  c=0
  while true; do
    cols=()
    echo "c=$c, #p=${#live[@]}"
    for i in "${!live[@]}"; do
      ((vx[$i]+=${ax[$i]}))
      ((vy[$i]+=${ay[$i]}))
      ((vz[$i]+=${az[$i]}))
      ((px[$i]+=${vx[$i]}))
      ((py[$i]+=${vy[$i]}))
      ((pz[$i]+=${vz[$i]}))
      p="${px[$i]}:${py[$i]}:${pz[$i]}"
      if [[ -n ${cols[$p]} ]]; then
        echo "collision $i with ${cols[$p]}"
        unset "live[$i]"
        unset "live[${cols[$p]}]"
      else
        cols[$p]=$i
      fi
    done
    ((c++))
  done
}
