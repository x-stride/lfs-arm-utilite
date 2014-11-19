#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/m4-1.4.17.tar.xz
cd /tmp/build/m4-1.4.17

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/m4-1.4.17" ] && rm -rf /tmp/build/m4-1.4.17
