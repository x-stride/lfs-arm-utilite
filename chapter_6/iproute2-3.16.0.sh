#!/bin/bash
set -e
echo "Doing iproute2-3.16.0"
SOURCE=/sources/iproute2-3.16.0.tar.xz
PKG=iproute2-3.16.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f iproute2-3.16.0.installed ];
then
  echo "Package iproute2-3.16.0 already installed."
else
  echo "Building iproute2-3.16.0"
  [ -d "/tmp/build/iproute2-3.16.0" ] && rm -rf /tmp/build/iproute2-3.16.0
  tar -xf /sources/iproute2-3.16.0.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i '/^TARGETS/s@arpd@@g' misc/Makefile
sed -i /ARPD/d Makefile
sed -i 's/arpd.8//' man/man8/Makefile

make
make DOCDIR=/usr/share/doc/iproute2-3.16.0 install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
