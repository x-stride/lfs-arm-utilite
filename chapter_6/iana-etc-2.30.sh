#!/bin/bash
set -e
echo "Doing iana-etc-2.30"
SOURCE=/sources/iana-etc-2.30.tar.bz2
PKG=iana-etc-2.30
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f iana-etc-2.30.installed ];
then
  echo "Package iana-etc-2.30 already installed."
else
  echo "Building iana-etc-2.30"
  [ -d "/tmp/build/iana-etc-2.30" ] && rm -rf /tmp/build/iana-etc-2.30
  tar -xf /sources/iana-etc-2.30.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
