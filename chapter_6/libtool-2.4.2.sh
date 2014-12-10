#!/bin/bash
set -e
echo "Doing libtool-2.4.2"
SOURCE=/sources/libtool-2.4.2.tar.gz
PKG=libtool-2.4.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f libtool-2.4.2.installed ];
then
  echo "Package libtool-2.4.2 already installed."
else
  echo "Building libtool-2.4.2"
  [ -d "/tmp/build/libtool-2.4.2" ] && rm -rf /tmp/build/libtool-2.4.2
  tar -xf /sources/libtool-2.4.2.tar.gz
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
