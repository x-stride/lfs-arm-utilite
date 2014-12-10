#!/bin/bash
set -e
echo "Doing acl-2.2.52"
SOURCE=/sources/acl-2.2.52.src.tar.gz
PKG=acl-2.2.52
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f acl-2.2.52.installed ];
then
  echo "Package acl-2.2.52 already installed."
else
  echo "Building acl-2.2.52"
  [ -d "/tmp/build/acl-2.2.52" ] && rm -rf /tmp/build/acl-2.2.52
  tar -xf /sources/acl-2.2.52.src.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i -e 's|/@pkg_name@|&-@pkg_version@|' include/builddefs.in
sed -i "s:| sed.*::g" test/{sbits-restore,cp,misc}.test
sed -i -e "/TABS-1;/a if (x > (TABS-1)) x = (TABS-1);" \
    libacl/__acl_to_any_text.c
./configure --prefix=/usr --libexecdir=/usr/lib
make
make install install-dev install-lib
chmod -v 755 /usr/lib/libacl.so
mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
