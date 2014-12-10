#!/bin/bash
set -e
echo "Doing automake-1.14.1"
SOURCE=/sources/automake-1.14.1.tar.xz
PKG=automake-1.14.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f automake-1.14.1.installed ];
then
  echo "Package automake-1.14.1 already installed."
else
  echo "Building automake-1.14.1"
  [ -d "/tmp/build/automake-1.14.1" ] && rm -rf /tmp/build/automake-1.14.1
  tar -xf /sources/automake-1.14.1.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.14.1
make
sed -i "s:./configure:LEXLIB=/usr/lib/libfl.a &:" t/lex-{clean,depend}-cxx.sh
make -j4 check
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
