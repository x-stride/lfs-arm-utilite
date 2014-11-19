#!/bin/bash
set -e

[ ! -d "/tmp/build" ] && mkdir -v /tmp/build
cd /tmp/build

tar -xvf /mnt/lfs/sources/perl-5.20.0.tar.bz2
cd /tmp/build/perl-5.20.0

sh Configure -des -Dprefix=/tools -Dlibs=-lm
make
cp -v perl cpan/podlators/pod2man /tools/bin
mkdir -pv /tools/lib/perl5/5.20.0
cp -Rv lib/* /tools/lib/perl5/5.20.0

[ -d "/tmp/build/perl-5.20.0" ] && rm -rf /tmp/build/perl-5.20.0
