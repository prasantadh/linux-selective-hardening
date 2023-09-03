obj-m += mmverify.o

.PHONY: all full

all: 	full

full: mmverify.c
	make LLVM=1 V=1 -C ~/workspace/src/linux M=$(PWD) -j $(nproc) modules

clean:
	rm -f *.ko
