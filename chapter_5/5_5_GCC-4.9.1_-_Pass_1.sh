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
tar -xf /mnt/lfs/sources/mpfr-3.1.2.tar.xz
mv -v mpfr-3.1.2 mpfr
tar -xf /mnt/lfs/sources/gmp-6.0.0a.tar.xz
mv -v gmp-6.0.0 gmp
tar -xf /mnt/lfs/sources/mpc-1.0.2.tar.gz
mv -v mpc-1.0.2 mpc

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

sed -i '/k prot/agcc_cv_libc_provides_ssp=yes' gcc/configure

sed -i 's/if \((code.*))\)/if (\1 \&\& \!DEBUG_INSN_P (insn))/' gcc/sched-deps.c


cd gmp
patch -Np1 -i /mnt/lfs/sources/gmp_thumb_add_mssaaaa.patch


cd /tmp/build/gcc-build
../gcc-4.9.1/configure                               \
    --target=$LFS_TGT                                \
    --prefix=/tools                                  \
    --with-sysroot=$LFS                              \
    --with-newlib                                    \
    --without-headers                                \
    --with-local-prefix=/tools                       \
    --with-native-system-header-dir=/tools/include   \
    --disable-nls                                    \
    --disable-shared                                 \
    --disable-multilib                               \
    --disable-decimal-float                          \
    --disable-threads                                \
    --disable-libatomic                              \
    --disable-libgomp                                \
    --disable-libitm                                 \
    --disable-libquadmath                            \
    --disable-libsanitizer                           \
    --disable-libssp                                 \
    --disable-libvtv                                 \
    --disable-libcilkrts                             \
    --disable-libstdc++-v3                           \
    --enable-languages=c,c++ $GCC_HF

make
make install

[ -d "/tmp/build/gcc-build" ] && rm -rf /tmp/build/gcc-build
[ -d "/tmp/build/gcc-4.9.1" ] && rm -rf /tmp/build/gcc-4.9.1
