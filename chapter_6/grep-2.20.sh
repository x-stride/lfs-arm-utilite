#!/bin/bash
set -e
echo "Doing grep-2.20"
SOURCE=/sources/grep-2.20.tar.xz
PKG=grep-2.20
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f grep-2.20.installed ];
then
  echo "Package grep-2.20 already installed."
else
  echo "Building grep-2.20"
  [ -d "/tmp/build/grep-2.20" ] && rm -rf /tmp/build/grep-2.20
  tar -xf /sources/grep-2.20.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --bindir=/bin
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
