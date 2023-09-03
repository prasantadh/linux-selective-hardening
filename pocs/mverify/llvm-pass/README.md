Build with

```bash
mkdir build 
cd build
cmake .. -DLLVM_ROOT=$HOME/workspace/bin/clang/17.0.0/release -DCMAKE_EXPORT_COMPILE_COMMANDS=1
make 
# not that this expects clang installed at ^ address
```

In the `test` folder, there is a `main.cpp` file which can be compiled to
LLVM bitcode with `clang -O1 -S -emit-llvm main.cpp`.

Then from the test folder to run the pass on the generated bitcode with opt,
we can do `opt -load-pass-plugin ../build/mverify/libmverify.so -passes="mverify" main.ll`
