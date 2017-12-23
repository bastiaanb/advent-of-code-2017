#include <stdio.h>
#include <stdlib.h>

int main(int argc, char **argv) {
  long a=1, b=0, c=0, d=0, e=0, f=0, g=0, h=0;
  b=93;
  c=b;
  if (a == 0) goto L9;
  b*=100;
  b-=-100000;
  c=b;
  c-=-17000;
  L9:
  f=1;
  d=2;
  L11:
  e=2;
  L12:
  g=d;
  g*=e;
  g-=b;
  if (g != 0) goto L17;
  f=0;
  L17:
  e-=-1;
  g=e;
  g-=b;
  if (g != 0) goto L12;
  d-=-1;
  g=d;
  g-=b;
  if (g != 0) goto L11;
  if (f != 0) goto L27;
  h-=-1;
  L27:
  g=b;
  g-=c;
  if (g != 0) goto L31;
  goto L33;
  L31:
  b-=-17;
  goto L9;
  L33: printf("%ld\n", h);
}
