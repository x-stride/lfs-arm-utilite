#!/bin/bash
set -e
echo "Doing grub-2.00"
SOURCE=/mnt/lfs/sources/grub-2.00.tar.xz
PKG=grub-2.00
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f grub-2.00.installed ];
then
  echo "Package grub-2.00 already installed."
else
  echo "Building grub-2.00"
  [ -d "/tmp/build/grub-2.00" ] && rm -rf /tmp/build/grub-2.00
  tar -xf /mnt/lfs/sources/grub-2.00.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
