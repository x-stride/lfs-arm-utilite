#!/bin/bash
set -e
echo "Doing bzip2-1.0.6"
SOURCE=/sources/bzip2-1.0.6.tar.gz
PKG=bzip2-1.0.6
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f bzip2-1.0.6.installed ];
then
  echo "Package bzip2-1.0.6 already installed."
else
  echo "Building bzip2-1.0.6"
  [ -d "/tmp/build/bzip2-1.0.6" ] && rm -rf /tmp/build/bzip2-1.0.6
  tar -xf /sources/bzip2-1.0.6.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


patch -Np1 -i /sources/bzip2-1.0.6-install_docs-1.patch
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

make -f Makefile-libbz2_so
make clean

make
make PREFIX=/usr install

cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
