#!/bin/bash
set -e
echo "Doing pkg-config-0.28"
SOURCE=/sources/pkg-config-0.28.tar.gz
PKG=pkg-config-0.28
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f pkg-config-0.28.installed ];
then
  echo "Package pkg-config-0.28 already installed."
else
  echo "Building pkg-config-0.28"
  [ -d "/tmp/build/pkg-config-0.28" ] && rm -rf /tmp/build/pkg-config-0.28
  tar -xf /sources/pkg-config-0.28.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr         \
            --with-internal-glib  \
            --disable-host-tool   \
            --docdir=/usr/share/doc/pkg-config-0.28

make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
