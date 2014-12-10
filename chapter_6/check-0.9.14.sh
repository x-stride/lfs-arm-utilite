#!/bin/bash
set -e
echo "Doing check-0.9.14"
SOURCE=/mnt/lfs/sources/check-0.9.14.tar.gz
PKG=check-0.9.14
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f check-0.9.14.installed ];
then
  echo "Package check-0.9.14 already installed."
else
  echo "Building check-0.9.14"
  [ -d "/tmp/build/check-0.9.14" ] && rm -rf /tmp/build/check-0.9.14
  tar -xf /mnt/lfs/sources/check-0.9.14.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
