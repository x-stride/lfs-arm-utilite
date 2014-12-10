#!/bin/bash
set -e
echo "Doing diffutils-3.3"
SOURCE=/sources/diffutils-3.3.tar.xz
PKG=diffutils-3.3
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f diffutils-3.3.installed ];
then
  echo "Package diffutils-3.3 already installed."
else
  echo "Building diffutils-3.3"
  [ -d "/tmp/build/diffutils-3.3" ] && rm -rf /tmp/build/diffutils-3.3
  tar -xf /sources/diffutils-3.3.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i 's:= @mkdir_p@:= /bin/mkdir -p:' po/Makefile.in.in
./configure --prefix=/usr
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
