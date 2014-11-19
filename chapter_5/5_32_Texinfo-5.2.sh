#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/texinfo-5.2.tar.xz
cd /tmp/build/texinfo-5.2

./configure --prefix=/tools
make
make check
make install

[ -d "/tmp/build/texinfo-5.2" ] && rm -rf /tmp/build/texinfo-5.2
