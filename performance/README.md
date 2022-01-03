# Profiling

for coverage info using the `kcbench` workload, use `coverage.info` provided in the repository.

## workflow

- edit `<linuxkit-root>/linuxkit/pkg/sysctl/etc/sysctl.d/00-linuxkit.conf` to have `kernel.unprivileged_bpf_disabled=0` and `kernel.perf_event_paranoid=-1`

- from `<linuxkit-root>/linuxkit/pkg/sysctl` run `docker build -t 'prasant/sysctl' --no-cache .`

- `make` builds kernels with full cfi, selective cfi and no cfi. consult the targets for each.

- `./deploy [ full | selective | none ]` deploys the desired kernel.
    
    - this will land you on a getty shell

    - run `ctr -n services.linuxkit t exec -t --exec-id sh ubuntu /bin/bash` to get into ubuntu container.

    - the ubuntu container has perf binaries and kernel modules as might be needed with the kernel loaded to play with.

- `./benchmark [ full | selective | none ]` deploys the desired kernel and gets result of running kcbench on the kernel inside the `results` folder.
