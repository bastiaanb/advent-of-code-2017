#!/bin/bash

walk() {
  v=0
  h=0
  for d in $(tr ',' ' '); do
    case "$d" in
       n) ((v+=2)) ;;
      ne) ((v+=1,h+=1)) ;;
      se) ((v-=1,h+=1)) ;;
       s) ((v-=2)) ;;
      sw) ((v-=1,h-=1)) ;;
      nw) ((v+=1,h-=1)) ;;
    esac

    hd=${h#-}
    vd=$(((v-h)/2))
    vd=${vd#-}
    if [[ -n $DRAW ]]; then
      echo -n "$(tput cup $((26-h/40)) $((105-v/40))) "
    else
      echo $((vd+hd))
    fi
  done
}

if [[ -n $DRAW ]]; then
  clear
  echo -n "$(tput setab 1)"
  walk < $1
else
  walk < $1 | tail -1
  walk < $1 | sort -nr | head -1
fi
