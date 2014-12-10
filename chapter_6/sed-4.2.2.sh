#!/bin/bash
set -e
echo "Doing sed-4.2.2"
SOURCE=/sources/sed-4.2.2.tar.bz2
PKG=sed-4.2.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f sed-4.2.2.installed ];
then
  echo "Package sed-4.2.2 already installed."
else
  echo "Building sed-4.2.2"
  [ -d "/tmp/build/sed-4.2.2" ] && rm -rf /tmp/build/sed-4.2.2
  tar -xf /sources/sed-4.2.2.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --bindir=/bin --htmldir=/usr/share/doc/sed-4.2.2
make
make html
make check
make install
make -C doc install-html


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
