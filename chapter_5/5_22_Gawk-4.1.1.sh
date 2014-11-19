#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/gawk-4.1.1.tar.xz
cd /tmp/build/gawk-4.1.1.tar.xz

./configure --prefix=/tools

make
make check
make install

[ -d "/tmp/build/gawk-4.1.1" ] && rm -rf /tmp/build/gawk-4.1.1
