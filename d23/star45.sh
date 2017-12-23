#!/bin/bash

OUT=/tmp/d23

{
  cat << EOF
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=0, b=0, c=0, d=0, e=0, f=0, g=0, h=0, m=0;
EOF

  pc=1
  while read ins X Y; do
    cat << EOF
  L$pc: fprintf(stderr, "$pc $ins $X $Y\t: %ld %ld %ld %ld %ld %ld %ld %ld %ld\n", a, b, c, d, e, f, g, h, m);
EOF
    case $ins in
      set) echo "  $X=$Y;"   ;; #X Y sets register X to the value of Y.
      sub) echo "  $X-=$Y;"  ;; #X Y increases register X by the value of Y.
      mul) echo "  $X*=$Y; m++;"  ;; #X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
      jnz) echo "  if ($X != 0) goto L$((pc+$Y));" ;; #X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)he value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
      *) echo "not matched: $ins" && exit 1 ;;
    esac
    ((pc++))
  done
  cat << EOF
  L$pc: printf("%ld\n", m);
}
EOF
} > $OUT.c

gcc -O3 -o $OUT $OUT.c

$OUT
