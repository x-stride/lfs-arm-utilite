#!/bin/bash

set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
[ -d "/tmp/build/binutils-build" ] && rm -rf /tmp/build/binutils-build

mkdir -v /tmp/build/binutils-build
[ -d "/tmp/build/binutils-2.24" ] && rm -rf /tmp/build/binutils-2.24
cd /tmp/build
tar -xvf /mnt/lfs/sources/binutils-2.24.tar.bz2
cd /tmp/build/binutils-build

../binutils-2.24/configure     \
    --prefix=/tools            \
    --with-sysroot=$LFS        \
    --with-lib-path=/tools/lib \
    --target=$LFS_TGT          \
    --disable-nls              \
    --disable-werror

make
make install

[ -d "/tmp/build/binutils-build" ] && rm -rf /tmp/build/binutils-build
[ -d "/tmp/build/binutils-2.24" ] && rm -rf /tmp/build/binutils-2.24
