#!/bin/bash
set -e
echo "Doing glibc-2.20"
SOURCE=/sources/glibc-2.20.tar.xz
PKG=glibc-2.20
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f glibc-2.20.installed ];
then
  echo "Package glibc-2.20 already installed."
else
  echo "Building glibc-2.20"
  [ -d "/tmp/build/glibc-2.20" ] && rm -rf /tmp/build/glibc-2.20
  tar -xf /sources/glibc-2.20.tar.xz
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


patch -Np1 -i /sources/glibc-2.20-fhs-1.patch

mkdir -v ../glibc-build
cd ../glibc-build

../glibc-2.20/configure    \
    --prefix=/usr          \
    --disable-profile      \
    --enable-kernel=2.6.32 \
    --enable-obsolete-rpc

make
make install

echo "Installing nscd file"
cp -v ../glibc-2.20/nscd/nscd.conf /etc/nscd.conf
mkdir -pv /var/cache/nscd

install -v -Dm644 ../glibc-2.20/nscd/nscd.tmpfiles /usr/lib/tmpfiles.d/nscd.conf
install -v -Dm644 ../glibc-2.20/nscd/nscd.service /lib/systemd/system/nscd.service

echo "Installing locales"
mkdir -pv /usr/lib/locale
localedef -i cs_CZ -f UTF-8 cs_CZ.UTF-8
localedef -i de_DE -f ISO-8859-1 de_DE
localedef -i de_DE@euro -f ISO-8859-15 de_DE@euro
localedef -i de_DE -f UTF-8 de_DE.UTF-8
localedef -i en_GB -f UTF-8 en_GB.UTF-8
localedef -i en_HK -f ISO-8859-1 en_HK
localedef -i en_PH -f ISO-8859-1 en_PH
localedef -i en_US -f ISO-8859-1 en_US
localedef -i en_US -f UTF-8 en_US.UTF-8
localedef -i es_MX -f ISO-8859-1 es_MX
localedef -i fa_IR -f UTF-8 fa_IR
localedef -i fr_FR -f ISO-8859-1 fr_FR
localedef -i fr_FR@euro -f ISO-8859-15 fr_FR@euro
localedef -i fr_FR -f UTF-8 fr_FR.UTF-8
localedef -i it_IT -f ISO-8859-1 it_IT
localedef -i it_IT -f UTF-8 it_IT.UTF-8
localedef -i ja_JP -f EUC-JP ja_JP
localedef -i ru_RU -f KOI8-R ru_RU.KOI8-R
localedef -i ru_RU -f UTF-8 ru_RU.UTF-8
localedef -i tr_TR -f UTF-8 tr_TR.UTF-8
localedef -i zh_CN -f GB18030 zh_CN.GB18030

echo "Installing nsswitch file"
cat <<EOF > /etc/nsswitch.conf
# Begin /etc/nsswitch.conf

passwd: files
group: files
shadow: files

hosts: files dns myhostname
networks: files

protocols: files
services: files
ethers: files
rpc: files

# End /etc/nsswitch.conf
EOF

cd ../glibc-2.20
echo "Making a weird tar file of tzdata"
tar -xf ../tzdata2014g.tar.gz

echo "Setting zoneinfo"
ZONEINFO=/usr/share/zoneinfo
mkdir -pv $ZONEINFO/{posix,right}

for tz in etcetera southamerica northamerica europe africa antarctica  \
          asia australasia backward pacificnew systemv; do
    zic -L /dev/null   -d $ZONEINFO       -y "sh yearistype.sh" ${tz}
    zic -L /dev/null   -d $ZONEINFO/posix -y "sh yearistype.sh" ${tz}
    zic -L leapseconds -d $ZONEINFO/right -y "sh yearistype.sh" ${tz}
done

cp -v zone.tab zone1970.tab iso3166.tab $ZONEINFO
zic -d $ZONEINFO -p America/New_York
unset ZONEINFO

echo "Linking to /usr/share/zoneinfo/UTC"
ln -sfv /usr/share/zoneinfo/UTC /etc/localtime

echo "Configuring /etc/ld.so.conf"
cat <<EOF > /etc/ld.so.conf
# Begin /etc/ld.so.conf
/usr/local/lib
/opt/lib

EOF

echo "Configuring more in /etc/ld.so.conf"
cat <<EOF >> /etc/ld.so.conf
# Add an include directory
include /etc/ld.so.conf.d/*.conf

EOF


echo "Making /etc/ld.so.conf.d directory"
mkdir -pv /etc/ld.so.conf.d


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
