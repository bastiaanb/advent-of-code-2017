#!/bin/bash

#n dec 271 if az < 3
#f inc -978 if nm <= 9

declare -A register

while read reg ins val iff opreg op opval ; do
  case $op in
     '<') [[ ${register[$opreg]} -lt $opval ]] ;;
     '>') [[ ${register[$opreg]} -gt $opval ]] ;;
    '<=') [[ ${register[$opreg]} -le $opval ]] ;;
    '>=') [[ ${register[$opreg]} -ge $opval ]] ;;
    '==') [[ ${register[$opreg]} -eq $opval ]] ;;
    '!=') [[ ${register[$opreg]} -ne $opval ]] ;;
  esac
  if [[ $? -eq 0 ]]; then
    case $ins in
      dec) ((register[$reg]-=$val)) ;;
      inc) ((register[$reg]+=$val)) ;;
    esac
  fi
done

echo "${register[@]}" | sed -e 's/ /\n/g' | sort -nr | head -1
