#!/bin/bash
set -e
echo "Doing gmp-6.0.0"
SOURCE=/sources/gmp-6.0.0a.tar.xz
PKG=gmp-6.0.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gmp-6.0.0.installed ];
then
  echo "Package gmp-6.0.0 already installed."
else
  echo "Building gmp-6.0.0"
  [ -d "/tmp/build/gmp-6.0.0" ] && rm -rf /tmp/build/gmp-6.0.0
  tar -xf /sources/gmp-6.0.0a.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG

  patch -Np1 -i /sources/gmp_thumb_add_mssaaaa.patch

./configure --prefix=/usr \
            --enable-cxx  \
            --docdir=/usr/share/doc/gmp-6.0.0a

make
make html
make check 2>&1 | tee gmp-check-log
awk '/tests passed/{total+=$2} ; END{print total}' gmp-check-log
make install
make install-html


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
