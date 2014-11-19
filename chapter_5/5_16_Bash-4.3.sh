#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/bash-4.3.tar.gz
cd /tmp/build/bash-4.3

patch -Np1 -i /mnt/lfs/sources/bash-4.3-upstream_fixes-3.patch

./configure --prefix=/tools --without-bash-malloc

make
make tests
make install

[ -d "/tmp/build/bash-4.3" ] && rm -rf /tmp/build/bash-4.3
