#!/bin/bash

c=0
tr  '[a-z=<>,]' ' ' | {
  while read px py pz vx vy vz ax ay az; do
    echo $c $((ax*ax + ay*ay + az*az)) $ax $ay $az
#    echo $c $px $py $pz $vx $vy $vz $ax $ay $az
    ((c++))
  done
} | sort -n -k 2 | head -1 | cut -f1 -d\  
