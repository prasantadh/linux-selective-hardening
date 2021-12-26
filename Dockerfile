FROM ubuntu:20.04 as kernel-build

ARG FEATURE

# copy the required files over
COPY / /

# install dependencies
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt update

RUN apt install -y \ 
    bash \ 
    wget \
    gnupg2 \
    lsb-core \
    software-properties-common \
    git \
    libncurses-dev \
    gawk \
    flex \
    bison \
    openssl \
    libssl-dev \
    dkms \
    libelf-dev \
    libudev-dev \
    libpci-dev \
    libiberty-dev \
    autoconf \
    iucode-tool


# get the compiler
RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 13

# download the kernel source
WORKDIR /
RUN mkdir -p /out/src
RUN git clone --progress --verbose --branch cfi-5.15 --depth=1 https://github.com/samitolvanen/linux.git

# Download Intel ucode 
# baa le biralo badhethe bhanera biralo badheko
# no clue why it's needed but linuxkit does it so so doing it
WORKDIR /tmp
ENV UCODE_REPO=https://github.com/intel/Intel-Linux-Processor-Microcode-Data-Files
ENV UCODE_COMMIT=microcode-20210216
RUN set -e && \
    if [ $(uname -m) = x86_64 ]; then \
        git clone --progress --verbose ${UCODE_REPO} ucode && \
        cd ucode && \
        git checkout ${UCODE_COMMIT} && \
        iucode_tool --normal-earlyfw --write-earlyfw=/out/intel-ucode.cpio ./intel-ucode && \
        cp license /out/intel-ucode-license.txt && \
        mkdir -p /lib/firmware && \
        cp -rav ./intel-ucode /lib/firmware; \
    fi
