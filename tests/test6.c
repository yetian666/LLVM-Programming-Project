#include <stdio.h>

int main() {
    int i, b, x, t;
    int p = 1;
    int a = 10;
L0:
    i = 0;
    b = 0;
    x = p;
LX:
    if (i < p) goto L1;
L4:
    b = b + 1;
    x = 0;
    return 1;

L1:
    t = a + 1;
    b = t;
    if (a == b) goto L2;
LY:
    a = x + 1;
    goto L3;
L2:
    a = x - 1;
L3:
    i = i + 1;
    goto L1;
    return 0;
}
