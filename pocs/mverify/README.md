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
