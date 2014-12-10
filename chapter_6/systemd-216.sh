#!/bin/bash
set -e
echo "Doing systemd-216"
SOURCE=/sources/systemd-216.tar.xz
PKG=systemd-216
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f systemd-216.installed ];
then
  echo "Package systemd-216 already installed."
else
  echo "Building systemd-216"
  [ -d "/tmp/build/systemd-216" ] && rm -rf /tmp/build/systemd-216
  tar -xf /sources/systemd-216.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


cat > config.cache << "EOF"
KILL=/bin/kill
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include/blkid"
cc_cv_CFLAGS__flto=no
EOF

sed -i "s:blkid/::" $(grep -rl "blkid/blkid.h")

patch -Np1 -i /sources/systemd-216-compat-1.patch
./configure --prefix=/usr                                           \
            --sysconfdir=/etc                                       \
            --localstatedir=/var                                    \
            --config-cache                                          \
            --with-rootprefix=                                      \
            --with-rootlibdir=/lib                                  \
            --enable-split-usr                                      \
            --disable-gudev                                         \
            --disable-firstboot                                     \
            --disable-ldconfig                                      \
            --disable-sysusers                                      \
            --without-python                                        \
            --docdir=/usr/share/doc/systemd-216                     \
            --with-dbuspolicydir=/etc/dbus-1/system.d               \
            --with-dbusinterfacedir=/usr/share/dbus-1/interfaces    \
            --with-dbussessionservicedir=/usr/share/dbus-1/services \
            --with-dbussystemservicedir=/usr/share/dbus-1/system-services
make LIBRARY_PATH=/tools/lib
sed -e "s:test/udev-test.pl::g"              \
    -e "s:test-bus-cleanup\$(EXEEXT) ::g"    \
    -e "s:test-condition-util\$(EXEEXT) ::g" \
    -e "s:test-dhcp6-client\$(EXEEXT) ::g"   \
    -e "s:test-engine\$(EXEEXT) ::g"         \
    -e "s:test-journal-flush\$(EXEEXT) ::g"  \
    -e "s:test-path-util\$(EXEEXT) ::g"      \
    -e "s:test-sched-prio\$(EXEEXT) ::g"     \
    -e "s:test-strv\$(EXEEXT) ::g"           \
    -i Makefile
make check
make LD_LIBRARY_PATH=/tools/lib install
mv -v /usr/lib/libnss_{myhostname,mymachines,resolve}.so.2 /lib
rm -rfv /usr/lib/rpm
for tool in runlevel reboot shutdown poweroff halt telinit; do
     ln -sfv ../bin/systemctl /sbin/${tool}
done
ln -sfv ../lib/systemd/systemd /sbin/init
sed -i "s:0775 root lock:0755 root root:g" /usr/lib/tmpfiles.d/legacy.conf
systemd-machine-id-setup


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
