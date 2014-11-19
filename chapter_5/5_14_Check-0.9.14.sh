#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/check-0.9.14.tar.gz
cd /tmp/build/check-0.9.14

PKG_CONFIG= ./configure --prefix=/tools

make
make check
make install

[ -d "/tmp/build/check-0.9.14" ] && rm -rf /tmp/build/check-0.9.14
