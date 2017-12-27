#!/bin/bash

tr '/' ' ' | {
  declare -A ports
  declare -A bridge

  while read from to; do
    ports[$from]+=" $to"
    [[ $from != "$to" ]] && ports[$to]+=" $from"
  done

  # for k in "${!ports[@]}"; do
  #   echo "$k: ${ports[$k]}"
  # done
  #
  # echo "====="

  strength=0
  depth=0
  path=""
  maxstrength=0
  maxdepth=0

  treesearch() {
    local from=$1
    local to s l
    local startpath=$path

    ((depth++))
    for to in ${ports[$from]}; do
      if [[ $from -lt $to ]]; then
        s=$from
        l=$to
      else
        s=$to
        l=$from
      fi
      if [[ -z ${bridge[$s:$l]} ]]; then
        ((strength+=from+to))
        bridge[$s:$l]=$depth
        path="$startpath $s:$l"
        if [[ $strength -gt $maxstrength ]]; then
          echo -e "$strength\t$depth\t$path"
          maxstrength=$strength
        fi
        if [[ $depth -ge $maxdepth ]]; then
          echo -e "$strength\t$depth\t$path"
          maxdepth=$depth
        fi
        treesearch $to
        unset "bridge[$s:$l]"
        ((strength-=from+to))
      fi
    done
    ((depth--))

    path=$startpath
  }

  treesearch 0
}
