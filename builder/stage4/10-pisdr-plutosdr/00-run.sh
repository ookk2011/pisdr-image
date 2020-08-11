#!/bin/bash -e

on_chroot << EOF
mkdir -p    "/home/${FIRST_USER_NAME}/PiSDR/Radios"
cd 		    "/home/${FIRST_USER_NAME}/PiSDR/Radios"

if [ ! -d "libiio" ]; then
    git clone https://github.com/analogdevicesinc/libiio
fi

cd libiio
mkdir -p build
cd build
cmake ../ -DINSTALL_UDEV_RULE=ON
make -j$(nproc) install
ldconfig
EOF