These are some experiments with kcfi.

`instrumentation-check` is provides instruction to see the kcfi instrumentation
on a binary.

`user-space` is an example of a user-space binary instrumented with kcfi

`kernel-module` is the same code as `user-space` ported to a kernel module

Eventually, we see that the kcfi has less than 1% overhead which makes this
mitigation cheap enough that it is best to apply it fully and not selectively.
Currently moving on to other mitigations such as KASAN
