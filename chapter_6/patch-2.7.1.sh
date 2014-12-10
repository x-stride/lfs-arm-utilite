#!/bin/bash
set -e
echo "Doing patch-2.7.1"
SOURCE=/sources/patch-2.7.1.tar.xz
PKG=patch-2.7.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f patch-2.7.1.installed ];
then
  echo "Package patch-2.7.1 already installed."
else
  echo "Building patch-2.7.1"
  [ -d "/tmp/build/patch-2.7.1" ] && rm -rf /tmp/build/patch-2.7.1
  tar -xf /sources/patch-2.7.1.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
