#!/bin/bash
set -e
echo "Doing gdbm-1.11"
SOURCE=/sources/gdbm-1.11.tar.gz
PKG=gdbm-1.11
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gdbm-1.11.installed ];
then
  echo "Package gdbm-1.11 already installed."
else
  echo "Building gdbm-1.11"
  [ -d "/tmp/build/gdbm-1.11" ] && rm -rf /tmp/build/gdbm-1.11
  tar -xf /sources/gdbm-1.11.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --enable-libgdbm-compat
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
