#Scripted Linux from Scratch, v 7.6-systemd

Linux from Scratch is a "book" describing how you can build your own Linux installation. http://www.linuxfromscratch.org/lfs/view/7.6-systemd/

I needed to rerun the steps as I got them wrong, or they needed some ARM patching - hence the script approach.
Also, some *real life* is nice to have while they're busy running :)

Target is for the Utilite Pro from CompuLab, http://www.compulab.co.il/utilite-computer/web/utilite-models
With minor tweaks it will probably work on other ARM devices too.


There are some additional downloads needed in chapter 4 in the book, other than that the scripts start off from chapter 5.



Build environment of user lfs, set in .bashrc:

````
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
```


