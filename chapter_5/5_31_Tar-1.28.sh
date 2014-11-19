#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/tar-1.28.tar.xz
cd /tmp/build/tar-1.28

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/tar-1.28" ] && rm -rf /tmp/build/tar-1.28
