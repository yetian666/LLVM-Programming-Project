int myfunc(int x, int y, int z) {
    return x + y + z;
}
int main() {
    int x, y, z;

    x = 12;
    y = x + 22;
    z = y + 33;
    int i = myfunc(x, y, z);
    return 0;
}
