#!/bin/bash
set -e
echo "Doing attr-2.4.47"
SOURCE=/sources/attr-2.4.47.src.tar.gz
PKG=attr-2.4.47
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f attr-2.4.47.installed ];
then
  echo "Package attr-2.4.47 already installed."
else
  echo "Building attr-2.4.47"
  [ -d "/tmp/build/attr-2.4.47" ] && rm -rf /tmp/build/attr-2.4.47
  tar -xf /sources/attr-2.4.47.src.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i -e "/SUBDIRS/s|man2||" man/Makefile
./configure --prefix=/usr
make
make -j1 tests root-tests
make install install-dev install-lib
chmod -v 755 /usr/lib/libattr.so
mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
