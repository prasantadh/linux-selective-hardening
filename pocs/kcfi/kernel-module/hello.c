#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/random.h>
#include <linux/types.h>
#include <linux/limits.h>
#include <linux/timekeeping.h>
#include <linux/kobject.h>

/* adapted from
 * https://blog.sourcerer.io/writing-a-simple-linux-kernel-module-d9dc3762c234
 * and
 * https://vincent.bernat.ch/en/blog/2017-linux-kernel-microbenchmark
 */

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Prasant Adhikari");
MODULE_DESCRIPTION("A simple kernel module");
MODULE_VERSION("0.0.1");

typedef int (*int_arg_fn)(int);
typedef int (*float_arg_fn)(float);

static volatile unsigned int idx = 0;
u64 nloops = 1;

static int int_arg(int arg) {
    return 0;
}

static int float_arg(float arg) {
    return 0;
}

struct foo {
    int_arg_fn int_funcs[1];
    float_arg_fn float_funcs[1];
};

static struct foo f = {
    .int_funcs = {int_arg},
    .float_funcs = {float_arg}
};


static u64 __attribute__ ((__noinline__)) proxy(void) {

    u64 runtime = ktime_get_real_ns();
    for (u64 counter = 0; counter < nloops; ++counter) {
        f.int_funcs[idx](idx);
    }
    runtime = ktime_get_real_ns() - runtime;

    return runtime;
}

static DEFINE_MUTEX(kb_lock);
/* function that will run on cat /sys/kernel/kbench/run */
static ssize_t run_show(struct kobject* kobj,
        struct kobj_attribute* attr,
        char* buf) {
    u64 runtime = proxy();
    u64 res;
    mutex_lock(&kb_lock);
    res = scnprintf(buf, PAGE_SIZE, "%llu\n", runtime);
    mutex_unlock(&kb_lock);
    return res;
}

/* Configurable parameters 
 * --idx for function to call
 * --loops for number of loops to run
 */

static ssize_t nloops_show(struct kobject *kobj,
                               struct kobj_attribute *attr,
                               char* buf) {
    ssize_t res;
    mutex_lock(&kb_lock);
    res = scnprintf(buf, PAGE_SIZE, "%llu\n", nloops);
    mutex_unlock(&kb_lock);
    return res;
}
static ssize_t nloops_store(struct kobject *kobj,
                                struct kobj_attribute *attr,
                                const char* buf,
                                size_t count) {
    u64 val = 0;
    int err = kstrtoull(buf, 0, &val);
    if (err < 0)
        return err;
    if (val < 1)
        return -EINVAL;
    mutex_lock(&kb_lock);
    nloops = val;
    mutex_unlock(&kb_lock);
    return count;
}


static ssize_t idx_show(struct kobject *kobj,
                               struct kobj_attribute *attr,
                               char* buf) {
    ssize_t res;
    mutex_lock(&kb_lock);
    res = scnprintf(buf, PAGE_SIZE, "%d\n", idx);
    mutex_unlock(&kb_lock);
    return res;
}
static ssize_t idx_store(struct kobject *kobj,
                                struct kobj_attribute *attr,
                                const char* buf,
                                size_t count) {
    unsigned int val = 0;
    int err = kstrtouint(buf, 0, &val);
    if (err < 0)
        return err;
    if (val < 1)
        return -EINVAL;
    mutex_lock(&kb_lock);
    idx = val;
    mutex_unlock(&kb_lock);
    return count;
}


/* data structures required to expose kernel objects */
static struct kobj_attribute nloops_attr = __ATTR_RW(nloops);
static struct kobj_attribute idx_attr = __ATTR_RW(idx);
static struct kobj_attribute run_attr = __ATTR_RO(run);
static struct attribute *bench_attributes[] = {
    &nloops_attr.attr,
    &idx_attr.attr,
    &run_attr.attr,
    NULL
};
static struct attribute_group bench_attr_group = {
    .attrs = bench_attributes
};
static struct kobject *bench_kobj;

static int __init lkm_example_init(void) {
    int rc;
    bench_kobj = kobject_create_and_add("kbench", kernel_kobj);
    if (!bench_kobj)
        return -ENOMEM;

    rc = sysfs_create_group(bench_kobj, &bench_attr_group);
    if (rc) {
        kobject_put(bench_kobj);
        return rc;
    }
    printk(KERN_INFO "Hello, world!\n");
    return 0;
}

static void __exit lkm_example_exit(void) {
    kobject_put(bench_kobj);
	printk(KERN_INFO "Goodbye, world\n");
}

module_init(lkm_example_init);
module_exit(lkm_example_exit);

