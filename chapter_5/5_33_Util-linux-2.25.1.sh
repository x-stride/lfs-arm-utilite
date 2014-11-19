#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/util-linux-2.25.1.tar.xz
cd /tmp/build/util-linux-2.25.1

./configure --prefix=/tools                \
            --without-python               \
            --disable-makeinstall-chown    \
            --without-systemdsystemunitdir \
            PKG_CONFIG=""
make
make install

[ -d "/tmp/build/util-linux-2.25.1" ] && rm -rf /tmp/build/util-linux-2.25.1
