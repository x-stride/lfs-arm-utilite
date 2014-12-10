#!/bin/bash
set -e
echo "Doing psmisc-22.21"
SOURCE=/sources/psmisc-22.21.tar.gz
PKG=psmisc-22.21
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f psmisc-22.21.installed ];
then
  echo "Package psmisc-22.21 already installed."
else
  echo "Building psmisc-22.21"
  [ -d "/tmp/build/psmisc-22.21" ] && rm -rf /tmp/build/psmisc-22.21
  tar -xf /sources/psmisc-22.21.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr
make
make install
mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
