#!/bin/bash
set -e
echo "Doing m4-1.4.17"
SOURCE=/sources/m4-1.4.17.tar.xz
PKG=m4-1.4.17
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f m4-1.4.17.installed ];
then
  echo "Package m4-1.4.17 already installed."
else
  echo "Building m4-1.4.17"
  [ -d "/tmp/build/m4-1.4.17" ] && rm -rf /tmp/build/m4-1.4.17
  tar -xf /sources/m4-1.4.17.tar.xz
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
