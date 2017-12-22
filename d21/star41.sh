#!/bin/bash

declare -A t

rot2r() {
  echo "${1:2:1}${1:0:1}${1:3:1}${1:1:1}"
}

flip2h() {
  echo "${1:1:1}${1:0:1}${1:3:1}${1:2:1}"
}

flip2v() {
  echo "${1:2:1}${1:3:1}${1:0:1}${1:1:1}"
}

#012
#345
#678
rot3r() {
  #630741852
  echo "${1:6:1}${1:3:1}${1:0:1}${1:7:1}${1:4:1}${1:1:1}${1:8:1}${1:5:1}${1:2:1}"
}

flip3h() {
  echo "${1:2:1}${1:1:1}${1:0:1}${1:5:1}${1:4:1}${1:3:1}${1:8:1}${1:7:1}${1:6:1}"
}

flip3v() {
  echo "${1:6:1}${1:7:1}${1:8:1}${1:3:1}${1:4:1}${1:5:1}${1:0:1}${1:1:1}${1:2:1}"
}

addTransforms() {
  to=$1
  shift
#  echo $1
  for i in "$@"; do
    t1="${t[$i]}"
    if [[ "$t1" == "" ]]; then
      t[$i]=$to
    elif [[ "$t1" != "$to" ]]; then
      echo "pattern $i already present with to $t1 instead of $to"
    fi
  done
}

tr -d '[/=>]' | {
  while read from to; do
    case "${#from}" in
      '4')
        r1=$(rot2r $from)
        r2=$(rot2r $r1)
        r3=$(rot2r $r2)
        addTransforms $to $from $r1 $r2 $r3
        fh=$(flip2h $from)
        r1=$(rot2r $fh)
        r2=$(rot2r $r1)
        r3=$(rot2r $r2)
        addTransforms $to $fh $r1 $r2 $r3
        fv=$(flip2v $from)
        r1=$(rot2r $fv)
        r2=$(rot2r $r1)
        r3=$(rot2r $r2)
        addTransforms $to $fv $r1 $r2 $r3
      ;;
      '9')
        r1=$(rot3r $from)
        r2=$(rot3r $r1)
        r3=$(rot3r $r2)
        addTransforms $to $from $r1 $r2 $r3
        fh=$(flip3h $from)
        r1=$(rot3r $fh)
        r2=$(rot3r $r1)
        r3=$(rot3r $r2)
        addTransforms $to $fh $r1 $r2 $r3
        fv=$(flip3v $from)
        r1=$(rot3r $fv)
        r2=$(rot3r $r1)
        r3=$(rot3r $r2)
        addTransforms $to $fv $r1 $r2 $r3
      ;;
      '*')
        echo "unsupported input $from."
        exit 1
    esac
  done

echo "${!t[@]}" | tr ' ' '\n' | sort

p=".#...####"
rowsize=3
for((i=0;i<5;i++)); do
  echo '-----------'
  egrep -o ".{$rowsize}" <<< $p
  o=0
  pnew=""
  if [[ $((rowsize%2)) -eq 0 ]]; then
    squares=$((rowsize/2))
    for((y=0;y<squares;y++)); do
      r1=""
      r2=""
      r3=""
      for((x=0;x<squares;x++)); do
        in=${p:o:2}${p:o+rowsize:2}
        out=${t[$in]}
        if [[ -z $out ]]; then
          echo "could not find transform for $in, x=$x, y=$y, o=$o, rowsize=$rowsize, i=$i, out=$out"
          exit 1
        fi
        r1+=${out:0:3}
        r2+=${out:3:3}
        r3+=${out:6:3}
        ((o+=2))
      done
      pnew+="$r1$r2$r3"
      ((o+=rowsize))
    done
    rowsize=$((squares*3))
  elif [[ $((rowsize%3)) -eq 0 ]]; then
    squares=$((rowsize/3))
    for((y=0;y<squares;y++)); do
      r1=""
      r2=""
      r3=""
      r4=""
      for((x=0;x<squares;x++)); do
        in=${p:o:3}${p:o+rowsize:3}${p:o+rowsize*2:3}
        out=${t[$in]}
        if [[ -z $out ]]; then
          echo "could not find transform for $in, x=$x, y=$y, rowsize=$rowsize, i=$i"
          exit 1
        fi
        r1+=${out:0:4}
        r2+=${out:4:4}
        r3+=${out:8:4}
        r4+=${out:12:4}
        ((o+=3))
      done
      pnew+="$r1$r2$r3$r4"
      ((o+=2*rowsize))
    done
    rowsize=$((squares*4))
  fi
  p=$pnew
done
  echo '-----------'
  egrep -o ".{$rowsize}" <<< $p
  egrep -o "#" <<< $p | wc -l
}
