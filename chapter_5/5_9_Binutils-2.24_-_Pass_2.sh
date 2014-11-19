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

CC=$LFS_TGT-gcc                \
AR=$LFS_TGT-ar                 \
RANLIB=$LFS_TGT-ranlib         \
../binutils-2.24/configure     \
    --prefix=/tools            \
    --disable-nls              \
    --disable-werror           \
    --with-lib-path=/tools/lib \
    --with-sysroot

make
make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

[ -d "/tmp/build/binutils-build" ] && rm -rf /tmp/build/binutils-build
[ -d "/tmp/build/binutils-2.24" ] && rm -rf /tmp/build/binutils-2.24
