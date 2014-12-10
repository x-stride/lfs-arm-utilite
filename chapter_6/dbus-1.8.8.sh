#!/bin/bash
set -e
echo "Doing dbus-1.8.8"
SOURCE=/sources/dbus-1.8.8.tar.gz
PKG=dbus-1.8.8
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f dbus-1.8.8.installed ];
then
  echo "Package dbus-1.8.8 already installed."
else
  echo "Building dbus-1.8.8"
  [ -d "/tmp/build/dbus-1.8.8" ] && rm -rf /tmp/build/dbus-1.8.8
  tar -xf /sources/dbus-1.8.8.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr                       \
            --sysconfdir=/etc                   \
            --localstatedir=/var                \
            --docdir=/usr/share/doc/dbus-1.8.8  \
            --with-console-auth-dir=/run/console
make
make install
mv -v /usr/lib/libdbus-1.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so
ln -sv /etc/machine-id /var/lib/dbus


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
