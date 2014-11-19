#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/ncurses-5.9.tar.gz
cd /tmp/build/ncurses-5.9

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite

make
make install

[ -d "/tmp/build/ncurses-5.9" ] && rm -rf /tmp/build/ncurses-5.9
