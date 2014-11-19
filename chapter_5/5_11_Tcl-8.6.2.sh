#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/tcl8.6.2-src.tar.gz
cd /tmp/build/tcl8.6.2/unix

./configure --prefix=/tools

make
TZ=UTC make test
make install

chmod -v u+w /tools/lib/libtcl8.6.so
make install-private-headers
ln -sv tclsh8.6 /tools/bin/tclsh

[ -d "/tmp/build/tcl8.6.2" ] && rm -rf /tmp/build/tcl8.6.2
