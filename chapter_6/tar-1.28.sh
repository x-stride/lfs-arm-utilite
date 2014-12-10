#!/bin/bash
set -e
echo "Doing tar-1.28"
SOURCE=/sources/tar-1.28.tar.xz
PKG=tar-1.28
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f tar-1.28.installed ];
then
  echo "Package tar-1.28 already installed."
else
  echo "Building tar-1.28"
  [ -d "/tmp/build/tar-1.28" ] && rm -rf /tmp/build/tar-1.28
  tar -xf /sources/tar-1.28.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
