#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/grep-2.20.tar.xz
cd /tmp/build/grep-2.20

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/grep-2.20" ] && rm -rf /tmp/build/grep-2.20
