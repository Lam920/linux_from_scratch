#!/bin/bash
mkdir -v build
cd build


#$LFS/tools: nstall the Binutils programs in the $LFS/tools directory
../configure --prefix=$LFS/tools \
 --with-sysroot=$LFS \
 --target=$LFS_TGT \
 --disable-nls \
 --enable-gprofng=no \
 --disable-werror \
 --enable-new-dtags \
 --enable-default-hash-style=gnu \
&& make && make install