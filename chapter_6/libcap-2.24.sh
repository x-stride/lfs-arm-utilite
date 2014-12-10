#!/bin/bash
set -e
echo "Doing libcap-2.24"
SOURCE=/sources/libcap-2.24.tar.xz
PKG=libcap-2.24
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f libcap-2.24.installed ];
then
  echo "Package libcap-2.24 already installed."
else
  echo "Building libcap-2.24"
  [ -d "/tmp/build/libcap-2.24" ] && rm -rf /tmp/build/libcap-2.24
  tar -xf /sources/libcap-2.24.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


make
make RAISE_SETFCAP=no prefix=/usr install
chmod -v 755 /usr/lib/libcap.so
mv -v /usr/lib/libcap.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libcap.so) /usr/lib/libcap.s


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
