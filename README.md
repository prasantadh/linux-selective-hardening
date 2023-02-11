# linux-selective-hardening
this repository provides details on how to profile linux-5.15 and use that profile to selectively instrument it with cfi all using linuxkit and docker.

## pre-requisite

- get [linuxkit](https://github.com/linuxkit/linuxkit.git) and checkout on `v0.8`

```bash
git clone https://github.com/linuxkit/linuxkit.git
cd linuxkit
git checkout v0.8
make
```

- make the binary in `bin/linuxkit` available to PATH

## tracks.py
Currently the Dockerfiles are a little unclean and requires running the following two commands for faster builds before interfacing with tracks.py

```bash
$ docker build --target benchmark-builder -t tracks/benchmark-builder -f Dockerfile.benchmark .
$ docker build --target kernel-builder -t tracks/kernel-builder -f Dockerfile.kernel .
```
