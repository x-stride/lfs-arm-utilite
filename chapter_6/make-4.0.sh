#!/bin/bash
set -e
echo "Doing make-4.0"
SOURCE=/sources/make-4.0.tar.bz2
PKG=make-4.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f make-4.0.installed ];
then
  echo "Package make-4.0 already installed."
else
  echo "Building make-4.0"
  [ -d "/tmp/build/make-4.0" ] && rm -rf /tmp/build/make-4.0
  tar -xf /sources/make-4.0.tar.bz2
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
