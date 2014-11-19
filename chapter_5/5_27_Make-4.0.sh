#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/make-4.0.tar.bz2
cd /tmp/build/make-4.0

./configure --prefix=/tools --without-guile
make
make check
make install

[ -d "/tmp/build/make-4.0" ] && rm -rf /tmp/build/make-4.0
