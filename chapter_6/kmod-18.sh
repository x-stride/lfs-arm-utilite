#!/bin/bash
set -e
echo "Doing kmod-18"
SOURCE=/sources/kmod-18.tar.xz
PKG=kmod-18
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f kmod-18.installed ];
then
  echo "Package kmod-18 already installed."
else
  echo "Building kmod-18"
  [ -d "/tmp/build/kmod-18" ] && rm -rf /tmp/build/kmod-18
  tar -xf /sources/kmod-18.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
make
make check
make install
for target in depmod insmod modinfo modprobe rmmod; do
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
