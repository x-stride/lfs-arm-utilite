#!/bin/bash
set -e
echo "Doing e2fsprogs-1.42.12"
SOURCE=/sources/e2fsprogs-1.42.12.tar.gz
PKG=e2fsprogs-1.42.12
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
[ ! -d "/tmp/build/e2fs-build" ] && mkdir -v /tmp/build/e2fs-build
cd /tmp/build
if [ -f e2fsprogs-1.42.12.installed ];
then
  echo "Package e2fsprogs-1.42.12 already installed."
else
  echo "Building e2fsprogs-1.42.12"
  [ -d "/tmp/build/e2fsprogs-1.42.12" ] && rm -rf /tmp/build/e2fsprogs-1.42.12
  tar -xf /sources/e2fsprogs-1.42.12.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  [ ! -d "/tmp/build/e2fs-build" ] && mkdir -v /tmp/build/e2fs-build
  cd /tmp/build/e2fs-build


LIBS=-L/tools/lib                            \
CFLAGS=-I/tools/include                      \
PKG_CONFIG_PATH=/tools/lib/pkgconfig         \
../e2fsprogs-1.42.12/configure --prefix=/usr \
             --bindir=/bin                   \
             --with-root-prefix=""           \
             --enable-elf-shlibs             \
             --disable-libblkid              \
             --disable-libuuid               \
             --disable-uuidd                 \
             --disable-fsck
make
ln -sfv /tools/lib/lib{blk,uu}id.so.1 lib
make LD_LIBRARY_PATH=/tools/lib check
make install
make install-libs
chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
  [ -d "/tmp/build/e2fs-build" ] && rm -rf /tmp/build/e2fs-build
fi
