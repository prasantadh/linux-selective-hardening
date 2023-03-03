#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int main(int argc, char** argv, char** envp) {

    for (unsigned int i = 0; i < UINT_MAX / 256; ++i) {
        int *a = (int *) malloc(sizeof(int));
        *a = argc;
        free((void *) a);
    }

    return 0;
}

