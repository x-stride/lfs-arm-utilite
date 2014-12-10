#!/bin/bash
set -e
echo "Doing util-linux-2.25.1"
SOURCE=/sources/util-linux-2.25.1.tar.xz
PKG=util-linux-2.25.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f util-linux-2.25.1.installed ];
then
  echo "Package util-linux-2.25.1 already installed."
else
  echo "Building util-linux-2.25.1"
  [ -d "/tmp/build/util-linux-2.25.1" ] && rm -rf /tmp/build/util-linux-2.25.1
  tar -xf /sources/util-linux-2.25.1.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


mkdir -pv /var/lib/hwclock
sed -e 's/2^64/(2^64/' -e 's/E </E) <=/' -e 's/ne /eq /' \
    -i tests/ts/ipcs/limits2
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linx-2.25.1
make
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
