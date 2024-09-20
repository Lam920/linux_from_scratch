#!/bin/bash
set +h
#set LFS to mount point
export LFS=/mnt/lfs 
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sdb
export LC_ALL=POSIX
PATH=/usr/bin
export PATH=$LFS/tools/bin:/usr/bin:/bin

#if nothing is mount at $LFS, then setup disk (disk is not mount to any point)
if ! grep -q "$LFS" /proc/mounts; then
    source setupdisk.sh "$LFS_DISK"
    sudo mount "${LFS_DISK}2" "$LFS" #mount /dev/sdb2 to /mnt/lfs
    sudo chown -v lfs "$LFS" #for mkdir later not need to root
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

#Chapter 5: binutils, gcc linux-6.10.5 glibc libstdc++
for package in binutils, gcc linux-6.10.5 glibc libstdc++ ; do
    source packageinstall.sh 5 $package
    echo "Chapter 5 is already compile"
done

#Chapter 6:

#for package in m4 ncurses bash coreutils diffutils file findutils gawk grep gzip make patch sed tar xz binutils gcc; do
# for package in bash; do
#     source packageinstall.sh bash
#     echo "Chapter 6 is already compile"
# done

# chmod ugo+x preparechroot.sh
# chmod ugo+x insidechroot.sh

# echo "PREPARE to CHROOT..."
# sudo ./preparechroot.sh "$LFS"
# echo "ENTERING CHROOT ENVIRONMENT...."
# sleep 3

# #LFS become new root, run sh for file in $LFS/sources/insidechroot.sh
# sudo chroot "$LFS" /usr/bin/env -i \
#     HOME=/root \
#     TERM="$TERM" \
#     PS1="(lfs chroot) \u:\w" \
#     PATH="/bin:/usr/bin:/sbin:usr/sbin" \
#     /usr/bin/bash --login +h -c "/sources/insidechroot.sh"


