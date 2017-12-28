#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
  int i = 4;
  int m=9, n=18, o;
  for(int i=4; 1; i+= m) {
    if ((i % 16 == 0) &&
       (i % 13 == 6) &&
       (i % 11 == 2) &&
       (i % 7 == 5) &&
       (i % 5 == 2) &&
       (i % 17 != 9)) {
      printf("%ld\n", i*2);
      exit(0);
    }
    o=m;
    m=n;
    n=o;
  }
}
