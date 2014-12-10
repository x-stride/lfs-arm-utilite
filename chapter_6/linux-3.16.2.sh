#!/bin/bash
set -e
echo "Doing linux-3.16.2"
SOURCE=/mnt/lfs/sources/linux-3.16.2.tar.xz
PKG=linux-3.16.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f linux-3.16.2.installed ];
then
  echo "Package linux-3.16.2 already installed."
else
  echo "Building linux-3.16.2"
  [ -d "/tmp/build/linux-3.16.2" ] && rm -rf /tmp/build/linux-3.16.2
  tar -xf /mnt/lfs/sources/linux-3.16.2.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
