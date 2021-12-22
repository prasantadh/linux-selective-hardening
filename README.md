# selective-cfi-on-linuxkit
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
