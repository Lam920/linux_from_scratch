#!/bin/bash

LFS_DISK="$1"

#EOF: Input to fdisk program: Create boot partition with 100MB and the remaining is for ROOTFS to mount later
sudo fdisk "$LFS_DISK" << EOF
o
n
p
1

+100M
a
n
p
2


p
w
q
EOF

#/dev/sdb1, 2 is ext2
# sudo mkfs -t ext2 -F "${LFS_DISK}1"
# sudo mkfs -t ext2 -F "${LFS_DISK}2"