#!/bin/bash

#set LFS to mount point
export LFS=/mnt/lfs 
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb

#if nothing is mount at $LFS, then setup disk (disk is not mount to any point)
if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS" #mount /dev/sdb2 to /mnt/lfs
    sudo chown -v $USER "$LFS"
fi

#for linux from scratch system
mkdir -pv $LFS/sources
mkdir -pv $LFS/tools #intermediater compiler to compile A->B

#normal file system
mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

echo $LFS_TGT | grep -qs '64'; then
    mkdir -pv $LFS/lib64
fi