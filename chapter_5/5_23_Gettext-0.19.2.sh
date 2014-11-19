#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/gettext-0.19.2.tar.xz
cd /tmp/build/gettext-0.19.2
cd gettext-tools

EMACS="no" ./configure --prefix=/tools --disable-shared

make -C gnulib-lib
make -C src msgfmt
make -C src msgmerge
make -C src xgettext

cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

[ -d "/tmp/build/gettext-0.19.2" ] && rm -rf /tmp/build/gettext-0.19.2
