#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/expect5.45.tar.gz
cd /tmp/build/expect5.45

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include

make test
make SCRIPTS="" install

[ -d "/tmp/build/expect5.45" ] && rm -rf /tmp/build/expect5.45
