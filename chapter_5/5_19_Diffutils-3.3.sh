#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/diffutils-3.3.tar.xz
cd /tmp/build/diffutils-3.3

./configure --prefix=/tools

make
make check
make install

[ -d "/tmp/build/diffutils-3.3" ] && rm -rf /tmp/build/diffutils-3.3
