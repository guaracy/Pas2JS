#!/bin/sh
DoExitAsm ()
{ echo "An error occurred while assembling $1"; exit 1; }
DoExitLink ()
{ echo "An error occurred while linking $1"; exit 1; }
echo Assembling uquinze
/usr/bin/as --64 -o /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/uquinze.o   /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/uquinze.s
if [ $? != 0 ]; then DoExitAsm uquinze; fi
rm /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/uquinze.s
echo Assembling quinze
/usr/bin/as --64 -o /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/quinze.o   /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/quinze.s
if [ $? != 0 ]; then DoExitAsm quinze; fi
rm /home/guaracy/devel/fpwebview/15/lib/x86_64-linux/quinze.s
echo Linking /home/guaracy/devel/fpwebview/15/quinze
OFS=$IFS
IFS="
"
/usr/bin/ld -b elf64-x86-64 -m elf_x86_64  --dynamic-linker=/lib64/ld-linux-x86-64.so.2       -L. -o /home/guaracy/devel/fpwebview/15/quinze -T /home/guaracy/devel/fpwebview/15/link19564.res -e _start
if [ $? != 0 ]; then DoExitLink /home/guaracy/devel/fpwebview/15/quinze; fi
IFS=$OFS
