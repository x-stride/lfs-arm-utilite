#!/bin/bash
set -e
echo "Doing xz-5.0.5"
SOURCE=/sources/xz-5.0.5.tar.xz
PKG=xz-5.0.5
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f xz-5.0.5.installed ];
then
  echo "Package xz-5.0.5 already installed."
else
  echo "Building xz-5.0.5"
  [ -d "/tmp/build/xz-5.0.5" ] && rm -rf /tmp/build/xz-5.0.5
  tar -xf /sources/xz-5.0.5.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --docdir=/usr/share/doc/xz-5.0.5
make
make check
make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/$(readlink /usr/lib/liblzma.so) /usr/lib/liblzma.so


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
