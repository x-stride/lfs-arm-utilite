#!/bin/bash
set -e
echo "Doing zlib-1.2.8"
SOURCE=/sources/zlib-1.2.8.tar.xz
PKG=zlib-1.2.8
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f zlib-1.2.8.installed ];
then
  echo "Package zlib-1.2.8 already installed."
else
  echo "Building zlib-1.2.8"
  [ -d "/tmp/build/zlib-1.2.8" ] && rm -rf /tmp/build/zlib-1.2.8
  tar -xf /sources/zlib-1.2.8.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr
make
make check
make install
mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
