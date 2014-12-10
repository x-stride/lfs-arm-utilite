#!/bin/bash
set -e
echo "Doing tcl8.6.2"
SOURCE=/mnt/lfs/sources/tcl8.6.2-src.tar.gz
PKG=tcl8.6.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f tcl8.6.2.installed ];
then
  echo "Package tcl8.6.2 already installed."
else
  echo "Building tcl8.6.2"
  [ -d "/tmp/build/tcl8.6.2" ] && rm -rf /tmp/build/tcl8.6.2
  tar -xf /mnt/lfs/sources/tcl8.6.2-src.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/tools
make
make check
make install


  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
