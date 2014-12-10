#!/bin/bash
set -e
echo "Doing binutils-2.24"
SOURCE=/sources/binutils-2.24.tar.bz2
PKG=binutils-2.24
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f binutils-2.24.installed ];
then
  echo "Package binutils-2.24 already installed."
else
  echo "Building binutils-2.24"
  [ -d "/tmp/build/binutils-2.24" ] && rm -rf /tmp/build/binutils-2.24
  [ -d "/tmp/build/binutils-build" ] && rm -rf /tmp/build/binutils-build
  tar -xf /sources/binutils-2.24.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


expect -c "spawn ls"

rm -fv etc/standards.info
sed -i.bak '/^INFO/s/standards.info //' etc/Makefile.in

patch -Np1 -i /sources/binutils-2.24-load_gcc_lto_plugin_by_default-1.patch

patch -Np1 -i /sources/binutils-2.24-lto_testsuite-1.patch

mkdir -v ../binutils-build
cd ../binutils-build

../binutils-2.24/configure --prefix=/usr   \
                           --enable-shared \
                           --disable-werror

make tooldir=/usr
make -k check
make tooldir=/usr install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
  [ -d "/tmp/build/binutils-build" ] && rm -rf /tmp/build/binutils-build
fi
