#!/bin/bash

SOURCE=$1
echo $SOURCE

tar -xf $SOURCE
PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
echo $PKG
rm -rf $PKG

cat <<EOF > $PKG.sh
#!/bin/bash
set -e
echo "Doing $PKG"
SOURCE=$SOURCE
PKG=$PKG
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f $PKG.installed ];
then
  echo "Package $PKG already installed."
else
  echo "Building $PKG"
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
  tar -xf $SOURCE
  PKG=\`find . -type d ! -path .|head -n 1|cut -f2 -d'/'\`
  cd /tmp/build/\$PKG


./configure --prefix=/tools
make
make check
make install


  touch \$PKG.installed
  [ -d "/tmp/build/\$PKG" ] && rm -rf /tmp/build/\$PKG
fi
EOF

