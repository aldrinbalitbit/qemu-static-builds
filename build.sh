#!/bin/bash -e
_msg() {
	echo -e "\e[1;32m>>\e[m $@"
}

_cur_dir="$(pwd)"

mkdir "${_cur_dir}"/{,qemu-}build
_msg "Cloning qemu"
git clone https://github.com/qemu/qemu.git >> "${_cur_dir}"/qemu-build/build.log 2>&1
cd qemu
_msg "Updating submodules"
git submodule update --init --recursive >> "${_cur_dir}"/qemu-build/build.log 2>&1
_msg "Configuring static for qemu"
./configure --prefix="${_cur_dir}"/qemu-build \
	    --static                          \
	    --enable-gcrypt                   \
	    --disable-system                  \
	    --disable-werror >> "${_cur_dir}"/qemu-build/build.log 2>&1
_msg "Building static forqemu"
make -j16 >> "${_cur_dir}"/qemu-build/build.log
_msg "Installing qemu static binaries"
make install >> "${_cur_dir}"/qemu-build/build.log
_msg "Stripping qemu static binaries"
find "${_cur_dir}"/qemu-build/bin -type f -exec strip --strip-all {} ';' >> "${_cur_dir}"/qemu-build/build.log
_msg "Copying qemu static binaries to the new build directory"
for i in "${_cur_dir}"/qemu-build/bin/*
do
	cp $i "${_cur_dir}"/build/$i-static
done
