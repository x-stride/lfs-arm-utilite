#!/bin/bash
set -e
echo "Doing gawk-4.1.1"
SOURCE=/sources/gawk-4.1.1.tar.xz
PKG=gawk-4.1.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gawk-4.1.1.installed ];
then
  echo "Package gawk-4.1.1 already installed."
else
  echo "Building gawk-4.1.1"
  [ -d "/tmp/build/gawk-4.1.1" ] && rm -rf /tmp/build/gawk-4.1.1
  tar -xf /sources/gawk-4.1.1.tar.xz
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
