#include <stdio.h>

int main() {
    int n;
    int sum;
    sum = 0;
    for (n = 0; n < 10; n++) {
        if (n > 1) sum = sum + n*n;
        else sum = sum + 0;
        if (0) return 1;
    }
    printf("sum: %d\n", sum);
    return 0;
}
