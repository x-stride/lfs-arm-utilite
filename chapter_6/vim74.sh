#!/bin/bash
set -e
echo "Doing vim74"
SOURCE=/sources/vim-7.4.tar.bz2
PKG=vim74
[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build
if [ -f vim74.installed ];
then
  echo "Package vim74 already installed."
else
  echo "Building vim74"
  [ -d "/tmp/build/vim74" ] && rm -rf /tmp/build/vim74
  tar -xf /sources/vim-7.4.tar.bz2
  PKG=`find . -type d ! -path .|head -n 1|cut -f2 -d'/'`
  cd /tmp/build/$PKG


echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h
./configure --prefix=/usr
make
make -j1 test > garbage
make install
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 $(dirname $L)/vi.1
done
ln -sv ../vim/vim74/doc /usr/share/doc/vim-7.4

cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

set nocompatible
set backspace=2
syntax on
if (&term == "iterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF


  cd /tmp/build
  touch $PKG.installed
  [ -d "/tmp/build/$PKG/garbage" ] && rm -rf /tmp/build/$PKG/garbage
  [ -d "/tmp/build/$PKG" ] && rm -rf /tmp/build/$PKG
fi
