#!/bin/bash
set -e
echo "Doing linux-3.10.17"
SOURCE=/sources/linux-3.10.17.tar.xz
PKG=linux-3.10.17
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f linux-3.10.17.installed ];
then
  echo "Package linux-3.10.17 already installed."
else
  echo "Building linux-3.10.17"
  [ -d "/tmp/build/linux-3.10.17" ] && rm -rf /tmp/build/linux-3.10.17
  tar -xf /sources/linux-3.10.17.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


make mrproper

make INSTALL_HDR_PATH=dest headers_install
find dest/include \( -name .install -o -name ..install.cmd \) -delete
cp -rv dest/include/* /usr/include

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
