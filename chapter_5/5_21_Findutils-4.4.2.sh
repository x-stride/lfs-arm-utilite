#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/findutils-4.4.2.tar.gz
cd /tmp/build/findutils-4.4.2

./configure --prefix=/tools

make
make check
make install

[ -d "/tmp/build/findutils-4.4.2" ] && rm -rf /tmp/build/findutils-4.4.2
