#!/bin/bash
set -e
echo "Doing findutils-4.4.2"
SOURCE=/sources/findutils-4.4.2.tar.gz
PKG=findutils-4.4.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f findutils-4.4.2.installed ];
then
  echo "Package findutils-4.4.2 already installed."
else
  echo "Building findutils-4.4.2"
  [ -d "/tmp/build/findutils-4.4.2" ] && rm -rf /tmp/build/findutils-4.4.2
  tar -xf /sources/findutils-4.4.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --localstatedir=/var/lib/locate
make
make check
make install
mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
