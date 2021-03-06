#!/bin/bash
set -e
echo "Doing gettext-0.19.2"
SOURCE=/sources/gettext-0.19.2.tar.xz
PKG=gettext-0.19.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gettext-0.19.2.installed ];
then
  echo "Package gettext-0.19.2 already installed."
else
  echo "Building gettext-0.19.2"
  [ -d "/tmp/build/gettext-0.19.2" ] && rm -rf /tmp/build/gettext-0.19.2
  tar -xf /sources/gettext-0.19.2.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --docdir=/usr/share/doc/gettext-0.19.2
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
