#!/bin/bash
set +euox

make clean
make

for file in $(find . -type f -executable | sort); do
    for i in {1..25}; do
        echo -n "$file ";
        ./$file 0
    done;
done;
