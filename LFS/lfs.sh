#!/bin/bash

#set LFS to mount point
export LFS=/mnt/lfs 
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

#if nothing is mount at $LFS, then setup disk (disk is not mount to any point)
if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS" #mount /dev/sdb2 to /mnt/lfs
    sudo chown -v lambt9 "$LFS" #for mkdir later not need to root
fi

#for linux from scratch system
mkdir -pv $LFS/sources
mkdir -pv $LFS/tools #intermediater compiler to compile A->B

#normal file system
mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/lib64
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

cp -rf *.sh chapter* package.csv "$LFS/sources"
cd "$LFS/sources"
export PATH="$LFS/tools/bin:$PATH"

source download.sh

#binutils, gcc linux-6.10.5 glibc libstdc++
for package in libstdc++; do
    source packageinstall.sh 5 $package
done


