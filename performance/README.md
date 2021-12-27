# Profiling

for coverage info using the `kcbench` workload, use `coverage.info` provided in the repository.

## workflow

- from `<linuxkit-root>/linuxkit/pkg/sysctl` run `docker build -t 'prasant/sysctl' --no-cache ."

- `make` builds kernels with full cfi, selective cfi and no cfi. consult the targets for each.

- `./deploy [ full | selective | none ]` deploys the desired kernel.

    - to have perf working

        - edit `<linuxkit-root>/linuxkit/pkg/sysctl/etc/sysctl.d/00-linuxkit.conf` 
        to have `kernel.unprivileged\_bpf\_disabled=0` and
        `kernel.perf\_event\_paranoid=-1`

    - kernel modules are available at `/proc/1/root/root/containers/services/kernel/rootfs/kernel.tar`
