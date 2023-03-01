This folder ports the code available at `../user-space` 
to a kernel module. Most of the work here is done by 
referencing the two blog posts:
- [on writing a kernel module](https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234)
- [microbenchmarking a kernel](https://vincent.bernat.ch/en/blog/2017-linux-kernel-microbenchmark)
As such, these blogs provide details on how to interract with the code here.
```bash
# write number of loops to run
$ cat 100 > /sys/kernel/kbench/nloops
# write the function to call
# 0: correct function, 1: incorrect function protected by CFI
$ cat 0 > /sys/kernel/kbench/idx
# run and get the result in ns
$ cat /sys/kernel/kbench/run
```
See the attached `Makefile` for building. It assumes
that the linux source is available at a certain location and
might need fixing. Current steps to run on my system is:
```bash
$ make all
# send the resulting .ko file to the kernel
$ insmod full.ko
# ^ makes the /sys/kernel/kbench/* endpoints available
```
