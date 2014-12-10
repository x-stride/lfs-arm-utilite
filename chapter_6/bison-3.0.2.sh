#!/bin/bash
set -e
echo "Doing bison-3.0.2"
SOURCE=/sources/bison-3.0.2.tar.xz
PKG=bison-3.0.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f bison-3.0.2.installed ];
then
  echo "Package bison-3.0.2 already installed."
else
  echo "Building bison-3.0.2"
  [ -d "/tmp/build/bison-3.0.2" ] && rm -rf /tmp/build/bison-3.0.2
  tar -xf /sources/bison-3.0.2.tar.xz
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
