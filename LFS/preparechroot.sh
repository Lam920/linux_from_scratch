#!/bin/bash
export LFS="$1"

if [ "$LFS" == "" ]; then
    exit 1
fi

#give root privilege for all folder in usb partition stick
sudo chown -R root:root $LFS/tools
sudo chown -R root:root $LFS/boot
sudo chown -R root:root $LFS/etc
sudo chown -R root:root $LFS/bin
sudo chown -R root:root $LFS/lib
sudo chown -R root:root $LFS/lib64
sudo chown -R root:root $LFS/sbin
sudo chown -R root:root $LFS/usr
sudo chown -R root:root $LFS/var

mkdir -pv $LFS/dev
mkdir -pv $LFS/proc
mkdir -pv $LFS/sys
mkdir -pv $LFS/run

#create dev file for system console and null device
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

echo "hello now"
#mount host /dev to usb stick dev
mount -v --bind /dev $LFS/dev
#pts: file for shell
mount --rbind /dev/ $LFS/dev/
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts

echo "Hi"

#sysfs: for communication with kernel
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
    mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi


