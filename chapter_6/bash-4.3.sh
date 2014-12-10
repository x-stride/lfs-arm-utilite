#!/bin/bash
set -e
echo "Doing bash-4.3"
SOURCE=/sources/bash-4.3.tar.gz
PKG=bash-4.3
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f bash-4.3.installed ];
then
  echo "Package bash-4.3 already installed."
else
  echo "Building bash-4.3"
  [ -d "/tmp/build/bash-4.3" ] && rm -rf /tmp/build/bash-4.3
  tar -xf /sources/bash-4.3.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


patch -Np1 -i /sources/bash-4.3-upstream_fixes-3.patch
./configure --prefix=/usr                    \
            --bindir=/bin                    \
            --docdir=/usr/share/doc/bash-4.3 \
            --without-bash-malloc            \
            --with-installed-readline
make
chown -Rv nobody .
su nobody -s /bin/bash -c "PATH=$PATH make tests"
make install


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
exec /bin/bash --login +h
fi
