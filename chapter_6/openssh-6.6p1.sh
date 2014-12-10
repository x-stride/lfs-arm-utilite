#!/bin/bash
set -e
echo "Doing openssh-6.6p1"
SOURCE=/sources/openssh-6.6p1.tar.gz
PKG=openssh-6.6p1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f openssh-6.6p1.installed ];
then
  echo "Package openssh-6.6p1 already installed."
else
  echo "Building openssh-6.6p1"
  [ -d "/tmp/build/openssh-6.6p1" ] && rm -rf /tmp/build/openssh-6.6p1
  tar -xf /sources/openssh-6.6p1.tar.gz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


install -v -m700 -d /var/lib/sshd &&
chown   -v root:sys /var/lib/sshd &&

groupadd -g 50 sshd &&
useradd -c 'sshd PrivSep' -d /var/lib/sshd -g sshd -s /bin/false -u 50 sshd

./configure --prefix=/usr                     \
            --sysconfdir=/etc/ssh             \
            --with-md5-passwords              \
            --with-privsep-path=/var/lib/sshd &&
make
make install                                  &&
install -v -m755 contrib/ssh-copy-id /usr/bin &&
install -v -m644 contrib/ssh-copy-id.1 /usr/share/man/man1 &&
install -v -m755 -d /usr/share/doc/openssh-6.6p1           &&
install -v -m644 INSTALL LICENCE OVERVIEW README* /usr/share/doc/openssh-6.6p1
echo "PermitRootLogin no" >> /etc/ssh/sshd_config

tar -xf /sources/blfs-systemd-units-20140907.tar.bz2
cd blfs-systemd-units-20140907
make install-sshd


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
