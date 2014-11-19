#!/bin/bash

set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

#We're doing kernel version 3.10.17 instead
[ -d "/tmp/build/linux-3.10.17" ] && rm -rf /tmp/build/linux-3.10.17
cd /tmp/build
tar -xvf /mnt/lfs/sources/linux-3.10.17.tar.xz
cd /tmp/build/linux-3.10.17

make mrproper
make INSTALL_HDR_PATH=dest headers_install
cp -rv dest/include/* /tools/include

[ -d "/tmp/build/linux-3.10.17" ] && rm -rf /tmp/build/linux-3.10.17
