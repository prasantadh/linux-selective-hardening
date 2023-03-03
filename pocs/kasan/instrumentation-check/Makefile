.PHONY: all

SRC=main.c

all: full selective none

full: ${SRC}
	clang -fsanitize=address $^ -o $@

selective: ${SRC}
	clang -fsanitize=address -fsanitize-ignorelist=`pwd`/ignorelist.txt $^ -o $@

none: ${SRC}
	clang $^ -o $@

clean: 
	rm full selective none
