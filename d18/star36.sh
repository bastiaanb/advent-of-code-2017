#!/bin/bash

OUT=/tmp/d18

{
  cat << EOF
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=0, b=0, f=0, i=0, p=0, s=0;
  char line[100];
  if (argc > 1) p=atoi(argv[1]);
EOF

  pc=1
  while read ins X Y; do
    cat << EOF
    L$pc: fprintf(stderr, "$pc $ins $X $Y\t: %ld %ld %ld %ld %ld %ld\n", a, b, f, i, p, s);
EOF
    case $ins in
      snd) echo "printf(\"%ld\\n\", $X); fflush(stdout); s++;";     ;; #X plays a sound with a frequency equal to the value of X.
      set) echo "$X=$Y;"   ;; #X Y sets register X to the value of Y.
      add) echo "$X+=$Y;"  ;; #X Y increases register X by the value of Y.
      mul) echo "$X*=$Y;"  ;; #X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
      mod) echo "$X%=$Y;"  ;; #X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
      rcv) cat << EOF
      if (fgets(line, sizeof(line) - 1, stdin)) {
        $X=atol(line);
        fprintf(stderr, "received %ld\n", $X);
      } else {
        fprintf(stderr, "failed to receive\n");
        exit(1);
      }
EOF
        ;; #X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
      jgz)
        [[ $Y == "p" ]] && Y=17 # hack to to input to get jump working
        echo "if ($X > 0) goto L$((pc+$Y));" ;; #X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)he value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
      *) echo "not matched: $ins" && exit 1 ;;
    esac
    ((pc++))
  done
  cat << EOF
}
EOF
} > $OUT.c

gcc -O3 -o $OUT $OUT.c

# file based fifos
cat /dev/null > /tmp/d18-fifo-0
cat /dev/null > /tmp/d18-fifo-1

tail -f /tmp/d18-fifo-1 | $OUT 0 >>/tmp/d18-fifo-0 2>/tmp/d18-0.err &
tail -f /tmp/d18-fifo-0 | $OUT 1 >>/tmp/d18-fifo-1 2>/tmp/d18-1.err &

# lame deadlock detection based on file size
previous="x"
while [[ "$previous" != "$status" ]]; do
  sleep 0.5
  previous=$status
  status=$(ls -l /tmp/d18-fifo-?)
done

# cleanup
killall $OUT
killall tail

# result
wc -l /tmp/d18-fifo-1
