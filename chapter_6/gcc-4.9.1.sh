#!/bin/bash
set -e
echo "Doing gcc-4.9.1"
SOURCE=/sources/gcc-4.9.1.tar.bz2
PKG=gcc-4.9.1
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f gcc-4.9.1.installed ];
then
  echo "Package gcc-4.9.1 already installed."
else
  echo "Building gcc-4.9.1"
  [ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1
  [ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build
  tar -xf /sources/gcc-4.9.1.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG

sed -i 's/if \((code.*))\)/if (\1 \&\& \!DEBUG_INSN_P (insn))/' gcc/sched-deps.c

patch -Np1 -i /sources/gcc-4.9.1-upstream_fixes-1.patch

mkdir -v ../gcc-build
cd ../gcc-build

SED=sed                       \
../gcc-4.9.1/configure        \
     --prefix=/usr            \
     --enable-languages=c,c++ \
     --disable-multilib       \
     --disable-bootstrap      \
     --with-system-zlib       \
     --with-arch=armv7-a --with-cpu=cortex-a9 --with-fpu=neon-fp16 --with-float=hard

make -j6

exit 1;

ulimit -s 32768
make -k check
../gcc-4.9.1/contrib/test_summary
make install
ln -sv ../usr/bin/cpp /lib
ln -sv gcc /usr/bin/cc

install -v -dm755 /usr/lib/bfd-plugins
ln -sfv ../../libexec/gcc/$(gcc -dumpmachine)/4.9.1/liblto_plugin.so /usr/lib/bfd-plugins/

echo 'main(){}' > dummy.c
cc dummy.c -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'

grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log

grep -B4 '^ /usr/include' dummy.log

grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'

grep "/lib.*/libc.so.6 " dummy.log

grep found dummy.log

rm -v dummy.c a.out dummy.log

mkdir -pv /usr/share/gdb/auto-load/usr/lib
mv -v /usr/lib/*gdb.py /usr/share/gdb/auto-load/usr/lib


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
  [ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build
fi
