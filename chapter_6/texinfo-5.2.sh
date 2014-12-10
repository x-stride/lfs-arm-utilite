#!/bin/bash
set -e
echo "Doing texinfo-5.2"
SOURCE=/sources/texinfo-5.2.tar.xz
PKG=texinfo-5.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f texinfo-5.2.installed ];
then
  echo "Package texinfo-5.2 already installed."
else
  echo "Building texinfo-5.2"
  [ -d "/tmp/build/texinfo-5.2" ] && rm -rf /tmp/build/texinfo-5.2
  tar -xf /sources/texinfo-5.2.tar.xz
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
