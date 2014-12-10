#!/bin/bash
set -e
echo "Doing procps-ng-3.3.9"
SOURCE=/sources/procps-ng-3.3.9.tar.xz
PKG=procps-ng-3.3.9
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f procps-ng-3.3.9.installed ];
then
  echo "Package procps-ng-3.3.9 already installed."
else
  echo "Building procps-ng-3.3.9"
  [ -d "/tmp/build/procps-ng-3.3.9" ] && rm -rf /tmp/build/procps-ng-3.3.9
  tar -xf /sources/procps-ng-3.3.9.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr                           \
            --exec-prefix=                          \
            --libdir=/usr/lib                       \
            --docdir=/usr/share/doc/procps-ng-3.3.9 \
            --disable-static                        \
            --disable-kill
make
sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
make check
make install
mv -v /usr/bin/pidof /bin
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libprocps.so) /usr/lib/libprocps.so

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
