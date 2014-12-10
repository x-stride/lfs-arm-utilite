#!/bin/bash
set -e
echo "Doing expat-2.1.0"
SOURCE=/sources/expat-2.1.0.tar.gz
PKG=expat-2.1.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f expat-2.1.0.installed ];
then
  echo "Package expat-2.1.0 already installed."
else
  echo "Building expat-2.1.0"
  [ -d "/tmp/build/expat-2.1.0" ] && rm -rf /tmp/build/expat-2.1.0
  tar -xf /sources/expat-2.1.0.tar.gz
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
