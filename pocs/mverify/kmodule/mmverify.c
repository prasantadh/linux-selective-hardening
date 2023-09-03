#include "linux/gfp_types.h"
#include <linux/kobject.h>
#include <linux/init.h>
#include <linux/list.h>
#include <linux/module.h>
#include <linux/slab.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Prasant Adhikari");
MODULE_DESCRIPTION("A kernel module that walks all allocated memory");
MODULE_VERSION("0.0.1");

// cat /sys/kernel/mmverify/run 
// will call the walk_allocs() function
static ssize_t run_show(struct kobject* kobj,
        struct kobj_attribute* attr,
        char* buf) {
    printk(KERN_INFO "====================================\n");
    void * addr;
    printk(KERN_INFO "kmalloced but before kfree\n");
    addr = kmalloc(1800, GFP_KERNEL);
    verify_my_address(addr);
    kfree(addr);
    printk(KERN_INFO "after kfree\n");
    verify_my_address(addr);
    printk(KERN_INFO "====================================\n");
    return 0;
}

static struct kobj_attribute run_attr = __ATTR_RO(run);
static struct attribute *mmverify_attributes[] = {
    &run_attr.attr,
    NULL
};
static struct attribute_group mmwalk_attr_group = {
    .attrs = mmverify_attributes
};
static struct kobject *mmverify_kobj;

static int __init entryfn(void) {
    int rc;
    mmverify_kobj = kobject_create_and_add("mmverify", kernel_kobj);
    if (!mmverify_kobj)
        return -ENOMEM;

    rc = sysfs_create_group(mmverify_kobj, &mmwalk_attr_group);
    if (rc) {
        kobject_put(mmverify_kobj);
        return rc;
    }

    printk(KERN_INFO "module initialized!");

    return 0;
}

static void __exit exitfn(void) {
    printk(KERN_INFO "exiting module!");
}

module_init(entryfn);
module_exit(exitfn);
