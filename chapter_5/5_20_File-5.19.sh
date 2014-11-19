#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

#Upped to v 5.20
tar -xvf /mnt/lfs/sources/file-5.20.tar.gz
cd /tmp/build/file-5.20

./configure --prefix=/tools

make
make check
make install

[ -d "/tmp/build/file-5.20" ] && rm -rf /tmp/build/file-5.20
