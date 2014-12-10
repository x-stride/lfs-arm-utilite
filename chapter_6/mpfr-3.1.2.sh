#!/bin/bash
set -e
echo "Doing mpfr-3.1.2"
SOURCE=/sources/mpfr-3.1.2.tar.xz
PKG=mpfr-3.1.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f mpfr-3.1.2.installed ];
then
  echo "Package mpfr-3.1.2 already installed."
else
  echo "Building mpfr-3.1.2"
  [ -d "/tmp/build/mpfr-3.1.2" ] && rm -rf /tmp/build/mpfr-3.1.2
  tar -xf /sources/mpfr-3.1.2.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG

patch -Np1 -i /sources/mpfr-3.1.2-upstream_fixes-2.patch

./configure --prefix=/usr        \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-3.1.2

make
make html
make check
make install
make install-html


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
