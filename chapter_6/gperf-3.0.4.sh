#!/bin/bash
set -e
echo "Doing gperf-3.0.4"
SOURCE=/sources/gperf-3.0.4.tar.gz
PKG=gperf-3.0.4
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gperf-3.0.4.installed ];
then
  echo "Package gperf-3.0.4 already installed."
else
  echo "Building gperf-3.0.4"
  [ -d "/tmp/build/gperf-3.0.4" ] && rm -rf /tmp/build/gperf-3.0.4
  tar -xf /sources/gperf-3.0.4.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.0.4
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
