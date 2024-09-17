#!/bin/bash
export LFS="$1"

if [ "$LFS" == "" ]; then
    exit 1
fi

#give root privilege for all folder in usb partition stick
sudo chown -R lambt9:lambt9 $LFS/tools
sudo chown -R lambt9:lambt9 $LFS/boot
sudo chown -R lambt9:lambt9 $LFS/etc
sudo chown -R lambt9:lambt9 $LFS/bin
sudo chown -R lambt9:lambt9 $LFS/lib
sudo chown -R lambt9:lambt9 $LFS/lib64
sudo chown -R lambt9:lambt9 $LFS/sbin
sudo chown -R lambt9:lambt9 $LFS/usr
sudo chown -R lambt9:lambt9 $LFS/var

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


