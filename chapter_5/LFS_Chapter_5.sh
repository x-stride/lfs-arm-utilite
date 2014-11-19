#!/bin/bash
set -e

#Initial toolchain
./5_4_Binutils-2.24_-_Pass_1.sh
./5_5_GCC-4.9.1_-_Pass_1.sh
./5_6_Linux-3.16.2_API_Headers.sh
./5_7_Glibc-2.20.sh
./5_8_Libstdc++-4.9.1.sh
./5_9_Binutils-2.24_-_Pass_2.sh
./5_10_GCC-4.9.1_-_Pass_2.sh

#The rest of the chapter
./5_11_Tcl-8.6.2.sh
./5_12_Expect-5.45.sh
./5_13_DejaGNU-1.5.1.sh
./5_14_Check-0.9.14.sh
./5_15_Ncurses-5.9.sh
./5_16_Bash-4.3.sh

