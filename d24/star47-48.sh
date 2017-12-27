#!/bin/bash

tr '/' ' ' | {
  declare -A ports
  declare -A bridge

  while read from to; do
    ports[$from]+=" $to"
    [[ $from != "$to" ]] && ports[$to]+=" $from"
  done

  strength=0
  depth=0
  maxstrength=0
  maxdepth=0
  maxdepthstrength=0

  treesearch() {
    local from=$1
    local to s l

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
        if [[ $strength -gt $maxstrength ]]; then
          maxstrength=$strength
        fi
        if [[ $depth -ge $maxdepth ]]; then
          maxdepth=$depth
          if [[ $depth -gt $maxdepth ]] || [[ $strength -gt $maxdepthstrength ]]; then
            maxdepthstrength=$strength
          fi
        fi
        treesearch $to
        unset "bridge[$s:$l]"
        ((strength-=from+to))
      fi
    done
    ((depth--))

  }

  treesearch 0

  echo "max strength: $maxstrength"
  echo "max depth: $maxdepth with strength $maxdepthstrength"
}
