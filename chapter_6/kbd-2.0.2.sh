#!/bin/bash
set -e
echo "Doing kbd-2.0.2"
SOURCE=/sources/kbd-2.0.2.tar.gz
PKG=kbd-2.0.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f kbd-2.0.2.installed ];
then
  echo "Package kbd-2.0.2 already installed."
else
  echo "Building kbd-2.0.2"
  [ -d "/tmp/build/kbd-2.0.2" ] && rm -rf /tmp/build/kbd-2.0.2
  tar -xf /sources/kbd-2.0.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG

patch -Np1 -i /sources/kbd-2.0.2-backspace-1.patch
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock
make
make check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
