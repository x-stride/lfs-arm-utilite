#!/bin/bash
set -e
echo "Doing bc-1.06.95"
SOURCE=/sources/bc-1.06.95.tar.bz2
PKG=bc-1.06.95
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f bc-1.06.95.installed ];
then
  echo "Package bc-1.06.95 already installed."
else
  echo "Building bc-1.06.95"
  [ -d "/tmp/build/bc-1.06.95" ] && rm -rf /tmp/build/bc-1.06.95
  tar -xf /sources/bc-1.06.95.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


patch -Np1 -i /sources/bc-1.06.95-memory_leak-1.patch
./configure --prefix=/usr           \
            --with-readline         \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info
make
echo "quit" | ./bc/bc -l Test/checklib.b
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
