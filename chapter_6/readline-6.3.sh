#!/bin/bash
set -e
echo "Doing readline-6.3"
SOURCE=/sources/readline-6.3.tar.gz
PKG=readline-6.3
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f readline-6.3.installed ];
then
  echo "Package readline-6.3 already installed."
else
  echo "Building readline-6.3"
  [ -d "/tmp/build/readline-6.3" ] && rm -rf /tmp/build/readline-6.3
  tar -xf /sources/readline-6.3.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


patch -Np1 -i /sources/readline-6.3-upstream_fixes-2.patch
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install
./configure --prefix=/usr --docdir=/usr/share/doc/readline-6.3
make SHLIB_LIBS=-lncurses
make SHLIB_LIBS=-lncurses install
mv -v /usr/lib/lib{readline,history}.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libreadline.so) /usr/lib/libreadline.so
ln -sfv ../../lib/$(readlink /usr/lib/libhistory.so ) /usr/lib/libhistory.so


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
