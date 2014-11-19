#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/xz-5.0.5.tar.xz
cd /tmp/build/xz-5.0.5

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/xz-5.0.5" ] && rm -rf /tmp/build/xz-5.0.5
