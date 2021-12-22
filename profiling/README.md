# Profiling

for coverage info using the `kcbench` workload, use `coverage.info` provided in the repository.

## workflow
tldr; run `make` and leave it until the data is collected on `gcov-data.tar.gz`

- `make` builds three containers and deploys a linuxkit instance
    - target `build` creates container `prasant/linux-5.15-build` which is used to build the linux kernel v5.15
    - target `trim` creates container `prasant/linux-5.15-gcov` which gets just the necessary files from `prasant/linux-5.15-build` to function as a kernel for linuxkit.
    - target `ubuntu` builds `prasant/ubuntu`, a local copy of ubuntu with requirements needed to collect the gcov data.
    - target `deploy` deploys a linuxkit instance with the above containers in place.

- once the instance is booted, the script `gather-on-test.sh` runs inside `prasant/ubuntu` and collects gcov data. this data is sent back to the host via a netcat connection on port 8888.

- to check the that instance is done collecting data, check `file gcov-data.tar.gz`. Initially it is an empty file. When the type changes to a tar archive, the data has been collected.

- this data can be imported inside `prasant/linux-5.15-build` container to parse it.
    - `docker run --rm -ir --entrypoint /bin/bash "prasant/linuxkit-5.15-build"`
    - get `gcov-data.tar.gz` inside the container.
    - `lcov --capture --directory sys/kernel/debug/gcov/linux --base-directory /linux --output-file coverage.info`
