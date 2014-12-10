#!/bin/bash
set -e
echo "Doing flex-2.5.39"
SOURCE=/sources/flex-2.5.39.tar.bz2
PKG=flex-2.5.39
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f flex-2.5.39.installed ];
then
  echo "Package flex-2.5.39 already installed."
else
  echo "Building flex-2.5.39"
  [ -d "/tmp/build/flex-2.5.39" ] && rm -rf /tmp/build/flex-2.5.39
  tar -xf /sources/flex-2.5.39.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i -e '/test-bison/d' tests/Makefile.in
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.5.39
make
make check
make install
ln -sv flex /usr/bin/lex

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
