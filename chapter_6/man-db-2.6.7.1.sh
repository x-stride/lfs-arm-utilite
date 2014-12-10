#!/bin/bash
set -e
echo "Doing man-db-2.6.7.1"
SOURCE=/sources/man-db-2.6.7.1.tar.xz
PKG=man-db-2.6.7.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f man-db-2.6.7.1.installed ];
then
  echo "Package man-db-2.6.7.1 already installed."
else
  echo "Building man-db-2.6.7.1"
  [ -d "/tmp/build/man-db-2.6.7.1" ] && rm -rf /tmp/build/man-db-2.6.7.1
  tar -xf /sources/man-db-2.6.7.1.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr                          \
            --docdir=/usr/share/doc/man-db-2.6.7.1 \
            --sysconfdir=/etc                      \
            --disable-setuid                       \
            --with-browser=/usr/bin/lynx           \
            --with-vgrind=/usr/bin/vgrind          \
            --with-grap=/usr/bin/grap
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
