#!/bin/bash
set -e
echo "Doing hostapd-2.3"
SOURCE=/sources/hostapd-2.3.tar.gz
PKG=hostapd-2.3
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f hostapd-2.3.installed ];
then
  echo "Package hostapd-2.3 already installed."
else
  echo "Building hostapd-2.3"
  [ -d "/tmp/build/hostapd-2.3" ] && rm -rf /tmp/build/hostapd-2.3
  tar -xf /sources/hostapd-2.3.tar.gz
  cd /tmp/build/$PKG


./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
