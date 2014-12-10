#!/bin/bash
set -e
echo "Doing gzip-1.6"
SOURCE=/sources/gzip-1.6.tar.xz
PKG=gzip-1.6
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gzip-1.6.installed ];
then
  echo "Package gzip-1.6 already installed."
else
  echo "Building gzip-1.6"
  [ -d "/tmp/build/gzip-1.6" ] && rm -rf /tmp/build/gzip-1.6
  tar -xf /sources/gzip-1.6.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --bindir=/bin
make
make check
make install
mv -v /bin/{gzexe,uncompress,zcmp,zdiff,zegrep} /usr/bin
mv -v /bin/{zfgrep,zforce,zgrep,zless,zmore,znew} /usr/bin


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
