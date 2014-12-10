#!/bin/bash
set -e
echo "Doing wget-1.15"
SOURCE=/sources/wget-1.15.tar.xz
PKG=wget-1.15
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f wget-1.15.installed ];
then
  echo "Package wget-1.15 already installed."
else
  echo "Building wget-1.15"
  [ -d "/tmp/build/wget-1.15" ] && rm -rf /tmp/build/wget-1.15
  tar -xf /sources/wget-1.15.tar.xz
  cd /tmp/build/$PKG


./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
