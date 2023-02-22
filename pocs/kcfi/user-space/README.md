This directory provides the simplest example of playing with kernel control flow integrity (KCFI).

# Files
- `main.c` : A file that is intrumented using CFI. The code is is adapted from 
[trailofbits/clang-cfi-showcase](https://github.com/trailofbits/clang-cfi-showcase.git)
- `time.h` and `time.c` : Provides code to get the wall clock time. Adapted from 
[mbitsnbites/osbench](https://github.com/mbitsnbites/osbench)
- `Makefile`: Compile the code in this directory.
- `run.sh`: Clean then compile then run the binaries 25 times.
- `results.txt`: The result of me running this code with `run.sh`
- `process.sh`: Provides simple processing of the results obtained.

# Results
after `17179869192` calls to a CFI protected function

| level | min | max | mean | median |
|-------|-----|-----|------|--------|
none | 22.06324 | 22.642603 | 22.42269888 | 22.437275
selective | 22.133121 | 22.601026 | 22.41732364 | 22.457523
full | 25.011547 | 26.370495 | 26.09917208 | 26.133545

On average we see about no overhead with selective CFI
while we see about 16% overhead with full CFI
