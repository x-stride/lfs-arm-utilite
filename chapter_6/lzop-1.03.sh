#!/bin/bash
set -e
echo "Doing lzop-1.03"
SOURCE=/sources/lzop-1.03.tar.gz
PKG=lzo-2.08
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f lzop-1.03.installed ];
then
  echo "Package lzop-1.03 already installed."
else
  echo "Building lzop-1.03"
  [ -d "/tmp/build/lzop-1.03" ] && rm -rf /tmp/build/lzo-2.08
  tar -xf /sources/lzop-1.03.tar.gz
  PKG=lzop-1.03
  cd /tmp/build/$PKG


./configure --prefix=/usr                    \
            --enable-shared                  \
            --disable-static                 \
            --docdir=/usr/share/doc/lzop-1.03&&
make
make install


  cd /tmp/build
  touch lzop-1.03.installed
  [ -d "/tmp/build/lzop-1.03" ] && rm -rf /tmp/build/lzop-1.03
fi
