#!/bin/bash
set -e
echo "Doing dejagnu-1.5.1"
SOURCE=/mnt/lfs/sources/dejagnu-1.5.1.tar.gz
PKG=dejagnu-1.5.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f dejagnu-1.5.1.installed ];
then
  echo "Package dejagnu-1.5.1 already installed."
else
  echo "Building dejagnu-1.5.1"
  [ -d "/tmp/build/dejagnu-1.5.1" ] && rm -rf /tmp/build/dejagnu-1.5.1
  tar -xf /mnt/lfs/sources/dejagnu-1.5.1.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
