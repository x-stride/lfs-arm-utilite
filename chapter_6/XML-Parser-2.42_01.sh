#!/bin/bash
set -e
echo "Doing XML-Parser-2.42_01"
SOURCE=/sources/XML-Parser-2.42_01.tar.gz
PKG=XML-Parser-2.42_01
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f XML-Parser-2.42_01.installed ];
then
  echo "Package XML-Parser-2.42_01 already installed."
else
  echo "Building XML-Parser-2.42_01"
  [ -d "/tmp/build/XML-Parser-2.42_01" ] && rm -rf /tmp/build/XML-Parser-2.42_01
  tar -xf /sources/XML-Parser-2.42_01.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


perl Makefile.PL
make
make test
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
