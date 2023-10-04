This directory implements the proof of concept for checking if each memory access
is valid. 

## Implementation

There are three parts to this proof of concept:
1. The linux memory management subsystem provides a way to verify if a memory
address is valid: see `verify_my_address` function below.
2. A kernel module that makes some memory accesses: see `kmodule` directory
3. LLVM pass that instruments the module to call `verify_my_address` 
before each access: see `llvm-pass` directory

```c
// in mm/slab_common.c
// also remember to declare the function header in mm/slab.h 
void verify_my_address(void *object) {

    printk(KERN_INFO "pointer to verify: %pn", object);

    struct folio *folio;
    struct slab *slab;
    struct kmem_cache *s;
    void* freelist;

    folio = virt_to_folio(object);
    slab = folio_slab(folio);
    s = slab->slab_cache;
    // lock the slab then traverse the slab for all freelist
    // whatever memory is not in the freelist is in the allocated list
    freelist = slab->freelist;
    while (freelist) {
       printk(KERN_INFO "freelist pointer: %px", freelist);
       freelist = (void *) * (unsigned long *) ((char *) freelist + s->offset);
    }
    // if the object is in slab cache freelist, 
    //   it is a valid memory location
    // else 
    //   it is not a valid memory location
}
EXPORT_SYMBOL(verify_my_address);
```

The progress as it happens is documented in [https://prasantadh.notion.site/Weekly-Sync-994d0d6b19c440a5813c93fb7f417bc1?pvs=4](https://prasantadh.notion.site/Weekly-Sync-994d0d6b19c440a5813c93fb7f417bc1?pvs=4)

## Resources

The linux slab allocator can be difficult to understand. Here are a few resources:
- [https://www.youtube.com/watch?v=h0VMLXavx30](https://www.youtube.com/watch?v=h0VMLXavx30) The classic, the lecture from the author of the SLUB allocator
- [https://www.youtube.com/watch?v=pFi-JKgoX-I](https://www.youtube.com/watch?v=pFi-JKgoX-I) Drexel university lecture, super nice, super easy to get
- [https://blogs.oracle.com/linux/post/linux-slub-allocator-internals-and-debugging-1](https://blogs.oracle.com/linux/post/linux-slub-allocator-internals-and-debugging-1) oracle blogs diving into the internals.
- [https://www.youtube.com/watch?v=7aONIVSXiJ8](https://www.youtube.com/watch?v=7aONIVSXiJ8) introduction to linux memory management, great as a reminder on how the memory is divided in linux and also a reminder that we are primarily working with virual memory
- [https://ruffell.nz/programming/writeups/2019/02/15/looking-at-kmalloc-and-the-slub-memory-allocator.html](https://ruffell.nz/programming/writeups/2019/02/15/looking-at-kmalloc-and-the-slub-memory-allocator.html) looking into the slub allocator with kmalloc as the entry point. makes is easier to browse code.
- [PSPRAY](https://www.usenix.org/conference/usenixsecurity23/presentation/lee-yoochan) a very recent paper that actually tries to give you some background on how the memory allocator works.
- [https://www.kernel.org/doc/Documentation/x86/x86\_64/mm.txt](https://www.kernel.org/doc/Documentation/x86/x86_64/mm.txt) Linux Virtual Memory map, official documentation
- [https://www.kernel.org/doc/gorman/pdf/understand.pdf](https://www.kernel.org/doc/gorman/pdf/understand.pdf) often way more than necessary but sometimes indispensable
- And the official linux kernel source code repo

Aside from the linux slab allocator, this implementation requires a good amount 
of work with compiler instrumentation. Here are a few resources: 
- [https://www.cs.cornell.edu/~asampson/blog/llvm.html](https://www.cs.cornell.edu/~asampson/blog/llvm.html) Adrian Sampson's blog, LLVM for Grad Student. Good starting point read.
- [https://blog.trailofbits.com/2019/06/25/creating-an-llvm-sanitizer-from-hopes-and-dreams/] trail of bits winternship project to build a sanitizer. Associated codebase is at 
[https://github.com/trailofbits/llvm-sanitizer-tutorial](https://github.com/trailofbits/llvm-sanitizer-tutorial). The code itself wasn't too helpful, however the references point to 
a set of pull requests for type sanitizers which was indispensable in building 
a prototype [https://reviews.llvm.org/D32199](https://reviews.llvm.org/D32199)
(browse down to the "Stack" tab where there are associated patches for llvm,
clang, and runtime components of building a sanitizer)
- [https://reviews.llvm.org/D119296](https://reviews.llvm.org/D119296) KCFI sanitizer
pull request. This is a bit bulky and harder to read however seeing parallels
with type sanitizer can help.
- [https://reviews.llvm.org/D10411#inline-84598](https://reviews.llvm.org/D10411#inline-84598)
KASAN patch for the compiler. similar properties to KCFI patch.
- [https://llvm.org/docs/GettingInvolved.html](https://llvm.org/docs/GettingInvolved.html)
llvm office hours, must attend at least some to get involved and address questions
- [https://mukulrathi.com/create-your-own-programming-language/llvm-ir-cpp-api-tutorial/](https://mukulrathi.com/create-your-own-programming-language/llvm-ir-cpp-api-tutorial/)
a set of explanation and code for implementing your own programming language.
Very helpful to get usage scenario.
- [https://ucsd-cse231-w21.github.io/](https://ucsd-cse231-w21.github.io/) good
content on compiler design. Zoom recording is not available but the some slides 
are still pretty good. Particularly used this [https://ucsd-pl.github.io/cse231/wi18/tutorials/Introduction-to-LLVM.pdf](https://ucsd-pl.github.io/cse231/wi18/tutorials/Introduction-to-LLVM.pdf)
- There were some additional resources, primarily concerning the use of LLVM IRBuilder class.
However this came about more as SO answers. A lot of it will be apparent once
you start coding the compiler. Some of the work will be visible on the author's
llvm mverify pass implementation [https://github.com/prasantadh/llvm-project/tree/mverify](https://github.com/prasantadh/llvm-project/tree/mverify)

