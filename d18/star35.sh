#!/bin/bash

OUT=/tmp/d18

{
  cat << EOF
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=0, b=0, f=0, i=0, p=0, s=0;

EOF

  pc=1
  while read ins X Y; do
#     cat << EOF
#     L$pc: printf("$pc: %ld %ld %ld %ld %ld %ld\n", a, b, f, i, p, s);
# EOF
    echo -n "L$pc: "
    case $ins in
      snd) echo "s=$X;"    ;; #X plays a sound with a frequency equal to the value of X.
      set) echo "$X=$Y;"   ;; #X Y sets register X to the value of Y.
      add) echo "$X+=$Y;"  ;; #X Y increases register X by the value of Y.
      mul) echo "$X*=$Y;"  ;; #X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
      mod) echo "$X%=$Y;"  ;; #X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
#      rcv) echo "if (s != 0) $X=s;" ;; #X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
      rcv) cat << EOF
        if (s != 0) {
          printf("%ld\n", s);
          exit(0);
        }
EOF
        ;; #X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
      jgz) echo "if ($X > 0) goto L$((pc+$Y));" ;; #X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)he value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
      *) echo "not matched: $ins" && exit 1 ;;
    esac
    ((pc++))
  done
  cat << EOF
}
EOF
} > $OUT.c

gcc -O3 -o $OUT $OUT.c
$OUT
