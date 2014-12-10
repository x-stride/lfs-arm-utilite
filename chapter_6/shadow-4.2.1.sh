#!/bin/bash
set -e
echo "Doing shadow-4.2.1"
SOURCE=/sources/shadow-4.2.1.tar.xz
PKG=shadow-4.2.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f shadow-4.2.1.installed ];
then
  echo "Package shadow-4.2.1 already installed."
else
  echo "Building shadow-4.2.1"
  [ -d "/tmp/build/shadow-4.2.1" ] && rm -rf /tmp/build/shadow-4.2.1
  tar -xf /sources/shadow-4.2.1.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


sed -i 's/groups$(EXEEXT) //' src/Makefile.in
find man -name Makefile.in -exec sed -i 's/groups\.1 / /' {} \;
sed -i -e 's@#ENCRYPT_METHOD DES@ENCRYPT_METHOD SHA512@' \
       -e 's@/var/spool/mail@/var/mail@' etc/login.defs
sed -i 's@DICTPATH.*@DICTPATH\t/lib/cracklib/pw_dict@' etc/login.defs
sed -i 's/1000/999/' etc/useradd
./configure --sysconfdir=/etc --with-libcrack --with-group-name-max-length=32
make
make install
mv -v /usr/bin/passwd /bin


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
