#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/sed-4.2.2.tar.bz2
cd /tmp/build/sed-4.2.2

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/sed-4.2.2" ] && rm -rf /tmp/build/sed-4.2.2
