#!/bin/bash

((locx=0, locy=0))
dir=R
step=1

target=$((${1}-1))

while [[ $target -gt 0 ]] ; do
  if [[ $target -ge $step ]]; then
    m=$step
  else
    m=$target
  fi
  ((target-=m))
  case $dir in
    R)
      ((locx+=m))
      dir=U
    ;;
    U)
      ((locy+=m, step+=1))
      dir=L
    ;;
    L)
      ((locx-=m))
      dir=D
    ;;
    D)
      ((locy-=m, step+=1))
      dir=R
    ;;
  esac
done

echo $locx, $locy, $((${locx#-} + ${locy#-}))
