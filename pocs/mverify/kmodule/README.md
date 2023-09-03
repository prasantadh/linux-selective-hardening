To compile the kernel module:

```bash
make
```

Gotcha: The Makefile will compile this module against the linux source
build in `~/workspace/src/linux`. You might need to change this based 
on where your linux build is located.

The `mmverify.ko` file then has to be downloaded to the kernel being run
and loaded with `insmod mmverify.ko`.

Run the module code with `cat /sys/kernel/mmverify/run`. The output is available
via `dmesg`. 

TODO: return the output directly to the filesystem command.

