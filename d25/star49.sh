#!/bin/bash

state=A

#steps=6
#declare -A program=([A]=1RB [A1]=0LB [B]=1LA [B1]=1RA)

steps=12656374
declare -A program=([A]=1RB [A1]=0LC [B]=1LA [B1]=1LD [C]=1RD [C1]=0RC [D]=0LB [D1]=0RE [E]=1RC [E1]=1LF [F]=1LE [F1]=1RA)

# A0 1RB
# A1 0LC
# B0 1LA
# B1 1LD
# C0 1RD
# C1 0RC
# D0 0LB
# D1 0RE
# E0 1RC
# E1 1LF
# F0 1LE
# F1 1RA

i=0
declare -A tape

for((s=0; s<steps; s++)); do
  [[ $((s % 1000)) -eq 0 ]] && echo -e "$s\t$state\t$i\t${#tape[@]}"
  new=${program["$state${tape[$i]}"]}
  if [[ ${new:0:1} == '0' ]]; then
    unset "tape[$i]"
  else
    tape[$i]=1
  fi
  if [[ ${new:1:1} == 'L' ]]; then
    ((i++))
  else
    ((i--))
  fi
  state=${new:2:1}
done

echo ${#tape[@]}
