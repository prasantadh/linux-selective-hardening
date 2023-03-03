/pocs/kcfi was done before working on this. The code here is 
simply the code ported from there. As such, for explanation
and usage, please consult that folder.

## Observations:
- Didn't try enabling KASAN just for this module but not for the kernel.
    - the code here is compiled with kernel that was already configured to use KASan.
    then we use the flags to exclude parts of the code here from KASan.
- While the official documentation allows for skipping KASan only on a source file level,
the implementation seems to support exclusion on a function level.
- selective instrumentation that skips `proxy` function actually increases the size
of the module. This is because `ktime_get_real_ns` is brought in 
as what looks like a plt. Consult `selective.as` and `full.as` for more.
- noticeable performance difference is seen while running the module with full 
instrumentation vs. selective instrumentation. There is some jitter.
To stabilize the jitter, set `nloops` such that the code runs for about 30s.
On my system this number was somewhere close to 400000000.

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
