#!/bin/bash
set -e
echo "Doing diffutils-3.3"
SOURCE=/sources/lzo-2.08.tar.gz
PKG=lzo-2.08
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f lzo-2.08.installed ];
then
  echo "Package lzo-2.08 already installed."
else
  echo "Building lzo-2.08"
  [ -d "/tmp/build/lzo-2.08" ] && rm -rf /tmp/build/lzo-2.08
  tar -xf /sources/lzo-2.08.tar.gz
  PKG=lzo-2.08
  cd /tmp/build/$PKG


./configure --prefix=/usr                    \
            --enable-shared                  \
            --disable-static                 \
            --docdir=/usr/share/doc/lzo-2.06 &&
make
make install


  cd /tmp/build
  touch lzo-2.08.installed
  [ -d "/tmp/build/lzo-2.08" ] && rm -rf /tmp/build/lzo-2.08
fi
