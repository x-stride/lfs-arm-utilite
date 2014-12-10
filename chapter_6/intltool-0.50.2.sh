#!/bin/bash
set -e
echo "Doing intltool-0.50.2"
SOURCE=/sources/intltool-0.50.2.tar.gz
PKG=intltool-0.50.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f intltool-0.50.2.installed ];
then
  echo "Package intltool-0.50.2 already installed."
else
  echo "Building intltool-0.50.2"
  [ -d "/tmp/build/intltool-0.50.2" ] && rm -rf /tmp/build/intltool-0.50.2
  tar -xf /sources/intltool-0.50.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr
make
make check
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.50.2/I18N-HOWTO

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
