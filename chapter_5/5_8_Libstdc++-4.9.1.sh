#!/bin/bash

set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
[ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build

mkdir -v /tmp/build/gcc-build
[ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1
cd /tmp/build
tar -xvf /mnt/lfs/sources/gcc-4.9.1.tar.bz2

cd /tmp/build/gcc-build

../gcc-4.9.1/libstdc++-v3/configure \
    --host=$LFS_TGT                 \
    --prefix=/tools                 \
    --disable-multilib              \
    --disable-shared                \
    --disable-nls                   \
    --disable-libstdcxx-threads     \
    --disable-libstdcxx-pch         \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/4.9.1

make
make install

[ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build
[ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1
