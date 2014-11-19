#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/bzip2-1.0.6.tar.gz
cd /tmp/build/bzip2-1.0.6

make

make PREFIX=/tools install

[ -d "/tmp/build/bzip2-1.0.6" ] && rm -rf /tmp/build/bzip2-1.0.6
