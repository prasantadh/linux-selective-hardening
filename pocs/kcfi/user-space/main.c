#include <stdio.h>
#include <limits.h>
#include "time.h"

typedef int (*int_arg_fn)(int);
typedef int (*float_arg_fn)(int);

static int int_arg(int arg) {
    // printf("In %s: (%d)\n", __FUNCTION__, arg);
    return 0;
}

static int float_arg(int arg) {
    // printf("In %s: (%d)\n", __FUNCTION__, arg);
    return 0;
}

struct foo {
    int_arg_fn int_funcs[1];
    float_arg_fn float_funcs[1];
};

static struct foo f = {
    .int_funcs = {int_arg},
    .float_funcs = {float_arg}
};

int main(int argc, char** argv, char** envp) {
    /*
    if (argc != 2) {
        printf("Usage: %s <option>\n", argv[0]);
        printf("<option> values: ");
        printf("0\tcall correct function");
        printf("1\tcall wrong function with same signature");
    }
    printf("Calling a function...\n");
    */

    const double t0 = get_time();

    int idx = argv[1][0] - '0';
    volatile int ans = 0;
    unsigned long i = 0;
    for (; i < ULONG_MAX / INT_MAX * 2; ++i) {
        ans = f.int_funcs[idx](idx);
    }

    const double tt = get_time() - t0;
    printf("%f taken for %lu calls \n", tt, i);
    return ans;
    
}
