#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/dejagnu-1.5.1.tar.gz
cd /tmp/build/dejagnu-1.5.1

./configure --prefix=/tools
make install

make check

[ -d "/tmp/build/dejagnu-1.5.1" ] && rm -rf /tmp/build/dejagnu-1.5.1
