#!/bin/bash

# mount debugfs for data
mount -t debugfs none /sys/kernel/debug

# run benchmarks as per defined variables
if [ "$PHORONIX" = true ]; then
    DEST=PHORONIX
    phoronix-test-suite benchmark openssl pybench git build-linux-kernel redis apache nginx ipc-benchmark
elif [ "$SPEC" = true ]; then
    DEST=SPEC
    cd /root/spec
    source shrc
    runspec \
        --action run \
        --config Example-linux64-amd64-gcc43+.cfg \
        --noreportable \
        bzip2       \
        gcc         \
        mcf         \
        gobmk       \
        hmmer       \
        sjeng       \
        libquantum  \
        h264ref     \
        omnetpp     \
        astar       \
        xalancbmk
elif [ "$NAS" = true ]; then
    DEST=NAS
    cd /root/NPB3.4.2/NPB3.4-MPI/bin
    ./bt.A.x.mpi_io_full
    ./cg.A.x
    ./ep.A.x
    ./ft.A.x
    ./is.A.x
    ./lu.A.x
    ./mg.A.x
    ./sp.A.x
    cd /root/NPB3.4.2/NPB3.4-OMP/bin
    ./bt.A.x
    ./cg.A.x
    ./ep.A.x
    ./ft.A.x
    ./is.A.x
    ./lu.A.x
    ./mg.A.x
    ./sp.A.x
else
    DEST=NONE
    echo "nothing to see here!"
fi

# collect gcov data
DEST=$DEST-`date +%s`-"gcov-data.tar.gz"
## on performance containers, we won't have access to gcov data
# GCDA=/sys/kernel/debug/gcov
#
# if [ -z "$DEST" ] ; then
#       echo "Usage: $0 <output.tar.gz>" >&2
#         exit 1
# fi
#
# TEMPDIR=$(mktemp -d)
# echo Collecting data..
# find $GCDA -type d -exec mkdir -p $TEMPDIR/\{\} \;
# find $GCDA -name '*.gcda' -exec sh -c 'cat < $0 > '$TEMPDIR'/$0' {} \;
# find $GCDA -name '*.gcno' -exec sh -c 'cp -d $0 '$TEMPDIR'/$0' {} \;
# tar czf $DEST -C $TEMPDIR sys
# rm -rf $TEMPDIR
#
# echo "$DEST successfully created, copy to build system and unpack with:"
# echo "  tar xfz $DEST"

# send the data to host
## on performance containers, the data we send to main will be different
scp -o StrictHostKeyChecking=no \
    -o UserKnownHostsFile=/dev/null \
    $DEST \
    bhakku@10.0.2.2:/home/bhakku/workspace/data/$DEST

curl -X POST https://api.pushover.net/1/messages.json \
    --data-urlencode "user=uqa4re9umr2tazsaeasm8r6pg3vi1s" \
    --data-urlencode "token=a7gqrzzd5461ctpgazmaa4m5f96wiw" \
    --data-urlencode "message=profiling completed at $(date)"
