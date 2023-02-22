.PHONY: all

CC=clang
SRC=time.c main.c
BIN=none selective full

all: none selective full

none: $(SRC)
	clang $^ -o $@

selective: $(SRC)
	clang $^ -fsanitize=kcfi -fsanitize-ignorelist=ignorelist.txt -o $@

full: $(SRC)
	clang $^ -fsanitize=kcfi -o $@

clean:
	rm -rf $(BIN) *.stats
