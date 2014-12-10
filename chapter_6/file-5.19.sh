#!/bin/bash
set -e
echo "Doing file-5.19"
SOURCE=/sources/file-5.19.tar.gz
PKG=file-5.19
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f file-5.19.installed ];
then
  echo "Package file-5.19 already installed."
else
  echo "Building file-5.19"
  [ -d "/tmp/build/file-5.19" ] && rm -rf /tmp/build/file-5.19
  tar -xf /sources/file-5.19.tar.gz
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
