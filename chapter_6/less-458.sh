#!/bin/bash
set -e
echo "Doing less-458"
SOURCE=/sources/less-458.tar.gz
PKG=less-458
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f less-458.installed ];
then
  echo "Package less-458 already installed."
else
  echo "Building less-458"
  [ -d "/tmp/build/less-458" ] && rm -rf /tmp/build/less-458
  tar -xf /sources/less-458.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --sysconfdir=/etc
make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
