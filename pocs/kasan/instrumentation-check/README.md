This folder provides sample code to play with ASan.

With ignorelist.txt, we see that the instrumentation is different.
`malloc` continues to be substituted with `__interceptor_malloc` and
`free` with `__interceptor_free`. Even though, some of the checks
after the allocation are removed.

We see no measurable difference in performance of full and selective
binaries. However, there are huge differences in performance of
full/selective vs no-instrumentation binaries.

User Space programs couldn't compiled with KASan. This might mean
the performance might be more measurable on the KAsan side.

`vimdiff full.as selective.as` to see the differences.

`make all` to build the binaries and run them.
