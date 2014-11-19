#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/patch-2.7.1.tar.xz
cd /tmp/build/patch-2.7.1

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/patch-2.7.1" ] && rm -rf /tmp/build/patch-2.7.1
