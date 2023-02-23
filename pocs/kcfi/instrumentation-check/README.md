This folder has a quick test to check that the full kCFI is instrumenting the kernels
while selective kCFI is leaving that function out. For that, build a kernel with full kCFI
then track a function with kCFI applied. Then, put that function name in the ignorelist
and check the compiled kernel again to see the differences.

kCFI generally looks like the following
```asm
 ffffffff810063d4:   41 ba 62 12 1f 53       mov    r10d,0x531f1262
 ffffffff810063da:   45 03 53 f1             add    r10d,DWORD PTR [r11-0xf]
 ffffffff810063de:   74 02                   je     ffffffff810063e2 <events_sysfs_show+0x32>
 ffffffff810063e0:   0f 0b                   ud2
 ffffffff810063e2:   2e e8 38 0a f4 00       cs call ffffffff81f46e20 <__x86_indirect_thunk_r11>
 ```

Essentially, if you are about to make an indirect function call via `r11`, adding kCFI 
moves a value to `r10d` then adds this value to a 32-bit value located at `[r11-0xf]`.
If the result is 0, the check passed, else it failed.

To locate a function with kCFI applied, we can now simply search of `ud2` and see if
that is the function we want to use. Put this function name on a file in the [clang
special case list format](https://clang.llvm.org/docs/SanitizerSpecialCaseList.html).
See `test.txt` in this folder for example. The function chosen is `events_sysfs_show`.

Building with full kCFI, the function looks like the following:
```bash
>  make mrproper && make LLVM=1 defconfig && scripts/config -e CFI_CLANG -e CFI_PERMISSIVE && make LLVM=1 -j $(nproc)
> objdump -M intel --disassemble=events_sysfs_show vmlinux

vmlinux:     file format elf64-x86-64


Disassembly of section .text:

ffffffff810063b0 <events_sysfs_show>:
ffffffff810063b0:       f3 0f 1e fa             endbr64 
ffffffff810063b4:       41 56                   push   r14
ffffffff810063b6:       53                      push   rbx
ffffffff810063b7:       48 89 d3                mov    rbx,rdx
ffffffff810063ba:       49 89 f6                mov    r14,rsi
ffffffff810063bd:       48 8b 7e 20             mov    rdi,QWORD PTR [rsi+0x20]
ffffffff810063c1:       48 63 05 b0 3e a7 01    movsxd rax,DWORD PTR [rip+0x1a73eb0]        # ffffffff82a7a278 <x86_pmu+0x98>
ffffffff810063c8:       48 39 c7                cmp    rdi,rax
ffffffff810063cb:       73 1d                   jae    ffffffff810063ea <events_sysfs_show+0x3a>
ffffffff810063cd:       4c 8b 1d 9c 3e a7 01    mov    r11,QWORD PTR [rip+0x1a73e9c]        # ffffffff82a7a270 <x86_pmu+0x90>
ffffffff810063d4:       41 ba 62 12 1f 53       mov    r10d,0x531f1262
ffffffff810063da:       45 03 53 f1             add    r10d,DWORD PTR [r11-0xf]
ffffffff810063de:       74 02                   je     ffffffff810063e2 <events_sysfs_show+0x32>
ffffffff810063e0:       0f 0b                   ud2    
ffffffff810063e2:       2e e8 38 0a f4 00       cs call ffffffff81f46e20 <__x86_indirect_thunk_r11>
ffffffff810063e8:       eb 02                   jmp    ffffffff810063ec <events_sysfs_show+0x3c>
ffffffff810063ea:       31 c0                   xor    eax,eax
ffffffff810063ec:       49 8b 56 28             mov    rdx,QWORD PTR [r14+0x28]
ffffffff810063f0:       48 85 d2                test   rdx,rdx
ffffffff810063f3:       74 1a                   je     ffffffff8100640f <events_sysfs_show+0x5f>
ffffffff810063f5:       48 89 df                mov    rdi,rbx
ffffffff810063f8:       48 c7 c6 72 7e 6d 82    mov    rsi,0xffffffff826d7e72
ffffffff810063ff:       e8 6c d6 f1 00          call   ffffffff81f23a70 <sprintf>
ffffffff81006404:       48 98                   cdqe   
ffffffff81006406:       5b                      pop    rbx
ffffffff81006407:       41 5e                   pop    r14
ffffffff81006409:       2e e9 f5 0e f4 00       cs jmp ffffffff81f47304 <__x86_return_thunk>
ffffffff8100640f:       4c 8b 1d ea 3e a7 01    mov    r11,QWORD PTR [rip+0x1a73eea]        # ffffffff82a7a300 <x86_pmu+0x120>
ffffffff81006416:       48 89 df                mov    rdi,rbx
ffffffff81006419:       48 89 c6                mov    rsi,rax
ffffffff8100641c:       5b                      pop    rbx
ffffffff8100641d:       41 5e                   pop    r14
ffffffff8100641f:       41 ba 76 c5 74 a9       mov    r10d,0xa974c576
ffffffff81006425:       45 03 53 f1             add    r10d,DWORD PTR [r11-0xf]
ffffffff81006429:       74 02                   je     ffffffff8100642d <events_sysfs_show+0x7d>
ffffffff8100642b:       0f 0b                   ud2    
ffffffff8100642d:       2e e9 ed 09 f4 00       cs jmp ffffffff81f46e20 <__x86_indirect_thunk_r11>

Disassembly of section .init.text:

Disassembly of section .altinstr_aux:

Disassembly of section .altinstr_replacement:

Disassembly of section .exit.text:
```

Now, build with selective kCFI and inspect the disassembly of the function
```bash
> make mrproper && make LLVM=1 defconfig && scripts/config -e CFI_CLANG -e CFI_PERMISSIVE && make LLVM=1 -j `nproc` V=1 KCFLAGS="-fsanitize-ignorelist=$(pwd)/test.txt"
...
> objdump -M intel --disassemble=events_sysfs_show vmlinux                                                                                                                

vmlinux:     file format elf64-x86-64


Disassembly of section .text:

ffffffff810063b0 <events_sysfs_show>:
ffffffff810063b0:       f3 0f 1e fa             endbr64 
ffffffff810063b4:       41 56                   push   r14
ffffffff810063b6:       53                      push   rbx
ffffffff810063b7:       48 89 d3                mov    rbx,rdx
ffffffff810063ba:       49 89 f6                mov    r14,rsi
ffffffff810063bd:       48 8b 7e 20             mov    rdi,QWORD PTR [rsi+0x20]
ffffffff810063c1:       48 63 05 b0 3e a7 01    movsxd rax,DWORD PTR [rip+0x1a73eb0]        # ffffffff82a7a278 <x86_pmu+0x98>
ffffffff810063c8:       48 39 c7                cmp    rdi,rax
ffffffff810063cb:       73 0f                   jae    ffffffff810063dc <events_sysfs_show+0x2c>
ffffffff810063cd:       4c 8b 1d 9c 3e a7 01    mov    r11,QWORD PTR [rip+0x1a73e9c]        # ffffffff82a7a270 <x86_pmu+0x90>
ffffffff810063d4:       2e e8 46 0a f4 00       cs call ffffffff81f46e20 <__x86_indirect_thunk_r11>
ffffffff810063da:       eb 02                   jmp    ffffffff810063de <events_sysfs_show+0x2e>
ffffffff810063dc:       31 c0                   xor    eax,eax
ffffffff810063de:       49 8b 56 28             mov    rdx,QWORD PTR [r14+0x28]
ffffffff810063e2:       48 85 d2                test   rdx,rdx
ffffffff810063e5:       74 1a                   je     ffffffff81006401 <events_sysfs_show+0x51>
ffffffff810063e7:       48 89 df                mov    rdi,rbx
ffffffff810063ea:       48 c7 c6 72 7e 6d 82    mov    rsi,0xffffffff826d7e72
ffffffff810063f1:       e8 7a d6 f1 00          call   ffffffff81f23a70 <sprintf>
ffffffff810063f6:       48 98                   cdqe   
ffffffff810063f8:       5b                      pop    rbx
ffffffff810063f9:       41 5e                   pop    r14
ffffffff810063fb:       2e e9 03 0f f4 00       cs jmp ffffffff81f47304 <__x86_return_thunk>
ffffffff81006401:       4c 8b 1d f8 3e a7 01    mov    r11,QWORD PTR [rip+0x1a73ef8]        # ffffffff82a7a300 <x86_pmu+0x120>
ffffffff81006408:       48 89 df                mov    rdi,rbx
ffffffff8100640b:       48 89 c6                mov    rsi,rax
ffffffff8100640e:       5b                      pop    rbx
ffffffff8100640f:       41 5e                   pop    r14
ffffffff81006411:       2e e9 09 0a f4 00       cs jmp ffffffff81f46e20 <__x86_indirect_thunk_r11>

Disassembly of section .init.text:

Disassembly of section .altinstr_aux:

Disassembly of section .altinstr_replacement:

Disassembly of section .exit.text:
```

We can see that the artifacts of kCFI are gone for this function.

TODO: The same approach with another function `x86_get_pmu` doesn't work.
It might be worth digging into it later on to see why. For now, locate a
path to a function in the kernel to see the performance impact.
