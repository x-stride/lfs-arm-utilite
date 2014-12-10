#!/bin/bash
set -e
echo "Doing expect5.45"
SOURCE=/mnt/lfs/sources/expect5.45.tar.gz
PKG=expect5.45
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f expect5.45.installed ];
then
  echo "Package expect5.45 already installed."
else
  echo "Building expect5.45"
  [ -d "/tmp/build/expect5.45" ] && rm -rf /tmp/build/expect5.45
  tar -xf /mnt/lfs/sources/expect5.45.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
