#!/bin/bash
set -e
echo "Doing man-pages-3.72"
SOURCE=/sources/man-pages-3.72.tar.xz
PKG=man-pages-3.72
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f man-pages-3.72.installed ];
then
  echo "Package man-pages-3.72 already installed."
else
  echo "Building man-pages-3.72"
  [ -d "/tmp/build/man-pages-3.72" ] && rm -rf /tmp/build/man-pages-3.72
  tar -xf /sources/man-pages-3.72.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
