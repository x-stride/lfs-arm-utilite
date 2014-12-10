#!/bin/bash
set -e
echo "Doing openssl-1.0.1i"
SOURCE=/sources/openssl-1.0.1i.tar.gz
PKG=openssl-1.0.1i
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f openssl-1.0.1i.installed ];
then
  echo "Package openssl-1.0.1i already installed."
else
  echo "Building openssl-1.0.1i"
  [ -d "/tmp/build/openssl-1.0.1i" ] && rm -rf /tmp/build/openssl-1.0.1i
  tar -xf /sources/openssl-1.0.1i.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic &&
make
sed -i 's# libcrypto.a##;s# libssl.a##' Makefile
make MANDIR=/usr/share/man MANSUFFIX=ssl install &&
install -dv -m755 /usr/share/doc/openssl-1.0.1i  &&
cp -vfr doc/*     /usr/share/doc/openssl-1.0.1i

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
