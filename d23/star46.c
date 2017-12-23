#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=1, b=0, c=0, d=0, e=0, f=0, g=0, h=0;
  for (b = 93*100 + 100000; b < 93*100 + 100000 + 17000; b += 17) {
    f=1;
    for (d=2; d != b; d++) {
      for (e=2; e != b; e++) {
        if (d * e - b == 0) {
          f=0;
        }
      }
      d++;
    }
    if (f == 0) {
      h++;
    }
  }
  L33: printf("%ld\n", h);
}
