#!/bin/bash

sed 's/[,<>-]//g' | {
  declare -A outgoing visited

  while read from tos; do
    outgoing[$from]=$tos
  done

  tovisit=(0)

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

  echo ${#visited[@]}
}
