#!/bin/bash
set -e
echo "Doing libpipeline-1.3.0"
SOURCE=/sources/libpipeline-1.3.0.tar.gz
PKG=libpipeline-1.3.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f libpipeline-1.3.0.installed ];
then
  echo "Package libpipeline-1.3.0 already installed."
else
  echo "Building libpipeline-1.3.0"
  [ -d "/tmp/build/libpipeline-1.3.0" ] && rm -rf /tmp/build/libpipeline-1.3.0
  tar -xf /sources/libpipeline-1.3.0.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
