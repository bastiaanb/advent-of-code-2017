#!/bin/bash

sed 's/[,<>-]//g' | {
  declare -A outgoing visited

  while read from tos; do
    outgoing[$from]=$tos
  done

  for ((count=0; ${#outgoing[@]} > 0; count++)); do
    keys=(${!outgoing[@]})
    tovisit=(${keys[0]})
    while [[ ${#tovisit[@]} -gt 0 ]]; do
      visiting=("${tovisit[@]}")
      tovisit=()
      for v in "${visiting[@]}"; do
        if [[ -z "${visited[$v]}" ]]; then
          visited[$v]=1
          tovisit+=(${outgoing[$v]})
        fi
      done
    done

    for i in "${!visited[@]}"; do
      unset outgoing[$i]
    done
  done

  echo $count
}
