#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=1, b=0, c=0, d=0, e=0, f=0, g=0, h=0;
  if (a == 0) {
    b = 93; c = 93;
  } else {
    b = 93*100 + 100000;
    c = 93*100 + 100000 + 17000;
  }
  for (/**/; b <= c; b += 17) {
    f=1;
    for (d=2; d < b; d++) {
      if ((b % d) == 0) {
        h++;
        f=0;
        break;
      }
    }
    printf("%ld: %ld %ld\n", b, h, f);
  }
  L33: printf("%ld\n", h);
}
