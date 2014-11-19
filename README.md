*Scripted Linux from Scratch, v 7.6-systemd*

Linux from Scratch is a "book" describing how you can build your own Linux installation. http://www.linuxfromscratch.org/lfs/view/7.6-systemd/
If you, like me, is a bit of a noob, and also don't have a lot of time to spend these scripts might work for you.

Yes, I needed to rerun the steps as I got them wrong, or they needed some ARM patching. And... I needed to leave them running while having some *real life*

I'm doing this on my own CompuLab Utilite Pro, http://www.compulab.co.il/utilite-computer/web/utilite-models
With minor tweaks it will probably work on other ARM devices too.


There are some additional downloads needed in chanpter 4 in the book, other than that the scripts start off from chapter 5.



Build environment of user lfs, set in .bashrc:

LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-hf-linux-gnueabihf

#Added hardfloat options for Utilite Pro
GCC_HF="--with-arch=armv7-a --with-cpu=cortex-a9 --with-fpu=neon-fp16 --with-float=hard"

MAKEFLAGS='-j 6'

unset CFLAGS
unset CXXFLAGS

PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT MAKEFLAGS PATH GCC_HF


