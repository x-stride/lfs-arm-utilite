#!/bin/bash
set -e
echo "Doing groff-1.22.2"
SOURCE=/sources/groff-1.22.2.tar.gz
PKG=groff-1.22.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f groff-1.22.2.installed ];
then
  echo "Package groff-1.22.2 already installed."
else
  echo "Building groff-1.22.2"
  [ -d "/tmp/build/groff-1.22.2" ] && rm -rf /tmp/build/groff-1.22.2
  tar -xf /sources/groff-1.22.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


PAGE=A4 ./configure --prefix=/usr
make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
