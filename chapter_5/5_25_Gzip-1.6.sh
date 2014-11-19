#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/gzip-1.6.tar.xz
cd /tmp/build/gzip-1.6

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/gzip-1.6" ] && rm -rf /tmp/build/gzip-1.6
