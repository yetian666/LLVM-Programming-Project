#include <stdio.h>

int a;
int A[10];
double b;
char c;
double d;

void swapValues(int left, int right){
  int tmp;

  tmp = A[right];
  A[right] = A[left];
  A[left] = tmp;

}

int findIndex(int st, int len){
  int j;
  int res;
  int max;

  res = -1;
  max = A[st];
  j = st + 1;
  while(j < len){
    if(A[j] > max){
      res = j;
      max = A[j];
    }
    j = j + 1;
  }
  return res;
}

int main(int argc, char **argv){
  int i;
  int k;
  int idx;

  i = 0;
  k = 0;
  while(k < 10){
    idx = findIndex(k,10);
    if(idx >= 0){
      swapValues(k,idx);
    }
    k = k + 1;
  }

  k = 10/2;
  idx = 10/2.0;
  i = k/2.0;
  d = (k * 3.1415);
  return 0;
}
