#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/coreutils-8.23.tar.xz
cd /tmp/build/coreutils-8.23

./configure --prefix=/tools --enable-install-program=hostname

make
make RUN_EXPENSIVE_TESTS=yes check
make install

[ -d "/tmp/build/coreutils-8.23" ] && rm -rf /tmp/build/coreutils-8.23
