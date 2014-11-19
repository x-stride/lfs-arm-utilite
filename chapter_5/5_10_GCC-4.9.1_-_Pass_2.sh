#!/bin/bash

set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
[ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build

mkdir -v /tmp/build/gcc-build
[ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1
cd /tmp/build
tar -xvf /mnt/lfs/sources/gcc-4.9.1.tar.bz2
cd /tmp/build/gcc-4.9.1

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include-fixed/limits.h

for file in \
 $(find gcc/config -name linux64.h -o -name linux.h -o -name sysv4.h -o -name linux-eabi.h -o -name linux-elf.h)
do
  cp -uv $file{,.orig}
  sed -e 's@/lib\(64\)\?\(32\)\?/ld@/tools&@g' \
      -e 's@/usr@/tools@g' $file.orig > $file
  echo '
#undef STANDARD_STARTFILE_PREFIX_1
#undef STANDARD_STARTFILE_PREFIX_2
#define STANDARD_STARTFILE_PREFIX_1 "/tools/lib/"
#define STANDARD_STARTFILE_PREFIX_2 ""' >> $file
  touch $file.orig
done


tar -xf /mnt/lfs/sources/mpfr-3.1.2.tar.xz
mv -v mpfr-3.1.2 mpfr
tar -xf /mnt/lfs/sources/gmp-6.0.0a.tar.xz
mv -v gmp-6.0.0 gmp
tar -xf /mnt/lfs/sources/mpc-1.0.2.tar.gz
mv -v mpc-1.0.2 mpc

sed -i 's/if \((code.*))\)/if (\1 \&\& \!DEBUG_INSN_P (insn))/' gcc/sched-deps.c


cd gmp
patch -Np1 -i /mnt/lfs/sources/gmp_thumb_add_mssaaaa.patch


cd /tmp/build/gcc-build
CC=$LFS_TGT-gcc                                      \
CXX=$LFS_TGT-g++                                     \
AR=$LFS_TGT-ar                                       \
RANLIB=$LFS_TGT-ranlib                               \
../gcc-4.9.1/configure                               \
    --prefix=/tools                                  \
    --with-local-prefix=/tools                       \
    --with-native-system-header-dir=/tools/include   \
    --enable-languages=c,c++                         \
    --disable-libstdcxx-pch                          \
    --disable-multilib                               \
    --disable-bootstrap                              \
    --disable-libgomp $GCC_HF

# Workaround for a problem introduced with GMP 5.1.0.
# If configured by gcc with the "none" host & target, it will result in undefined references to '__gmpn_invert_limb' during linking.
# Should be fixed by next version of gcc, but let me know if you have any more ideas on this.
sed -i 's/none-/armv7l-/' Makefile

make
make install

ln -sv gcc /tools/bin/cc

[ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build
[ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1

echo 'main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
