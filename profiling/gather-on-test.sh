#!/bin/bash

# mount debugfs for data
mount -t debugfs none /sys/kernel/debug

# run kcbench
cd /root
curl -O https://gitlab.com/knurd42/kcbench/-/raw/master/kcbench
bash kcbench -b -d -v -i 1 -j `nproc` > kcbench.log

# collect gcov data
DEST="gcov-data.tar.gz"
GCDA=/sys/kernel/debug/gcov

if [ -z "$DEST" ] ; then
      echo "Usage: $0 <output.tar.gz>" >&2
        exit 1
fi

TEMPDIR=$(mktemp -d)
echo Collecting data..
find $GCDA -type d -exec mkdir -p $TEMPDIR/\{\} \;
find $GCDA -name '*.gcda' -exec sh -c 'cat < $0 > '$TEMPDIR'/$0' {} \;
find $GCDA -name '*.gcno' -exec sh -c 'cp -d $0 '$TEMPDIR'/$0' {} \;
tar czf $DEST -C $TEMPDIR sys
rm -rf $TEMPDIR

echo "$DEST successfully created, copy to build system and unpack with:"
echo "  tar xfz $DEST"

# send the data to host
nc -N 10.0.2.2 8888 < $DEST
