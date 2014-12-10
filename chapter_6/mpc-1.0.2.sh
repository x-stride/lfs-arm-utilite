#!/bin/bash
set -e
echo "Doing mpc-1.0.2"
SOURCE=/sources/mpc-1.0.2.tar.gz
PKG=mpc-1.0.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f mpc-1.0.2.installed ];
then
  echo "Package mpc-1.0.2 already installed."
else
  echo "Building mpc-1.0.2"
  [ -d "/tmp/build/mpc-1.0.2" ] && rm -rf /tmp/build/mpc-1.0.2
  tar -xf /sources/mpc-1.0.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --docdir=/usr/share/doc/mpc-1.0.2
make
make html
make check
make install
make install-html

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
