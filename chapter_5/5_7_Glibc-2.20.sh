#!/bin/bash

set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
[ -d "/tmp/build/glibc-build" ] && rm -rf /tmp/build/glibc-build

mkdir -v /tmp/build/glibc-build
[ -d "/tmp/build/glibc-2.20" ] && rm -rf /tmp/build/glibc-2.20
cd /tmp/build
tar -xvf /mnt/lfs/sources/glibc-2.20.tar.xz
cd /tmp/build/glibc-build

if [ ! -r /usr/include/rpc/types.h ]; then
  su -c 'mkdir -pv /usr/include/rpc'
  su -c 'cp -v sunrpc/rpc/*.h /usr/include/rpc'
fi

../glibc-2.20/configure                             \
      --prefix=/tools                               \
      --host=$LFS_TGT                               \
      --build=$(../glibc-2.20/scripts/config.guess) \
      --disable-profile                             \
      --enable-kernel=2.6.32                        \
      --with-headers=/tools/include                 \
      libc_cv_forced_unwind=yes                     \
      libc_cv_ctors_header=yes                      \
      libc_cv_c_cleanup=yes

make
make install

[ -d "/tmp/build/glibc-build" ] && rm -rf /tmp/build/glibc-build
[ -d "/tmp/build/glibc-2.20" ] && rm -rf /tmp/build/glibc-2.20
