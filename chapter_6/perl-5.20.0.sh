#!/bin/bash
set -e
echo "Doing perl-5.20.0"
SOURCE=/sources/perl-5.20.0.tar.bz2
PKG=perl-5.20.0
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f perl-5.20.0.installed ];
then
  echo "Package perl-5.20.0 already installed."
else
  echo "Building perl-5.20.0"
  [ -d "/tmp/build/perl-5.20.0" ] && rm -rf /tmp/build/perl-5.20.0
  tar -xf /sources/perl-5.20.0.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


echo "127.0.0.1 localhost $(hostname)" > /etc/hosts
export BUILD_ZLIB=False
export BUILD_BZIP2=0
sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib
make
make -k test
make install
unset BUILD_ZLIB BUILD_BZIP2


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
