#!/bin/bash

INPUT=$(cat -)

level=0
garbage=0
ignore=0
count=0
garbagecount=0
for ((i=0; i < ${#INPUT}; i++)); do
  char=${INPUT:$i:1}
  [[ $((i % 100)) == 0 ]] && echo $i
  if [[ $garbage -eq 1 ]]; then
    if [[ $ignore -eq 1 ]]; then
      # do nothing
      ignore=0
    else
      case "$char" in
        '!') ignore=1  ;;
        '>') garbage=0 ;;
        *) ((garbagecount++)) ;;
      esac
    fi
  else
    case "$char" in
      '{') ((level++)) ;;
      '}') ((count+=level, level--)) ;;
      '<') garbage=1 ;;
    esac
  fi
done

echo "group count: $count"
echo "garbage count: $garbagecount"
