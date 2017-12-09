#!/bin/bash

declare -A register

max=0
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
    [[ ${register[$reg]} -gt $max ]] && max=${register[$reg]}
  fi
done

echo "${register[@]}" | sed -e 's/ /\n/g' | sort -nr | head -1
echo $max
