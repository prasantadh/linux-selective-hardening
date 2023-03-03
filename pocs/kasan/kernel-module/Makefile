obj-m += hello.o

.PHONY: all full selective none

all: full selective none
full:	full.ko
selective: selective.ko
none: none.ko

full.ko: hello.c
	make LLVM=1 -C ~/workspace/src/linux M=$(PWD) V=1 -j $(nproc) modules
	mv hello.ko full.ko

selective.ko: hello.c
	make LLVM=1 -C ~/workspace/src/linux M=$(PWD) V=1 -j $(nproc) KCFLAGS="-fsanitize-ignorelist=$(PWD)/ignorelist.txt" modules
	mv hello.ko selective.ko

none.ko: hello.c
	make LLVM=1 -C ~/workspace/src/linux M=$(PWD) V=1 -j $(nproc) modules 
	mv hello.ko none.ko

clean:
	make LLVM=1 -C ~/workspace/src/linux M=$(PWD) V=1 -j $(nproc) clean
	rm -f *.ko

