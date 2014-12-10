#!/bin/bash
set -e
echo "Doing autoconf-2.69"
SOURCE=/sources/autoconf-2.69.tar.xz
PKG=autoconf-2.69
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f autoconf-2.69.installed ];
then
  echo "Package autoconf-2.69 already installed."
else
  echo "Building autoconf-2.69"
  [ -d "/tmp/build/autoconf-2.69" ] && rm -rf /tmp/build/autoconf-2.69
  tar -xf /sources/autoconf-2.69.tar.xz
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
