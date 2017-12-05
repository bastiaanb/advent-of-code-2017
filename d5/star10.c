#include <stdio.h>
#include <stdlib.h>

int program[10000];
int c=0;
int p=0;

int main(int argc, char **argv) {
  int l=0;
  while(!feof(stdin)) {
    scanf("%d", &program[l++]);
  }
  l--;

  while(p >= 0 && p < l) {
    int s = program[p];
    if (s >= 3)
      program[p]--;
    else
      program[p]++;
    p += s;
    c++;
  }

  printf("%d, %d\n", c, p);
}
