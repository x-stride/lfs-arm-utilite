#!/bin/bash
set -e
echo "Doing inetutils-1.9.2"
SOURCE=/sources/inetutils-1.9.2.tar.gz
PKG=inetutils-1.9.2
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f inetutils-1.9.2.installed ];
then
  echo "Package inetutils-1.9.2 already installed."
else
  echo "Building inetutils-1.9.2"
  [ -d "/tmp/build/inetutils-1.9.2" ] && rm -rf /tmp/build/inetutils-1.9.2
  tar -xf /sources/inetutils-1.9.2.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG

echo '#define PATH_PROCNET_DEV "/proc/net/dev"' >> ifconfig/system/linux.h 
./configure --prefix=/usr  \
            --localstatedir=/var   \
            --disable-logger       \
            --disable-whois        \
            --disable-servers
make
make check
make install
mv -v /usr/bin/{hostname,ping,ping6,traceroute} /bin
mv -v /usr/bin/ifconfig /sbin


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
