#!/bin/bash -e

on_chroot << EOF
mkdir -p 	"/home/${FIRST_USER_NAME}/PiSDR/Software"
cd 		    "/home/${FIRST_USER_NAME}/PiSDR/Software"
if [ ! -d "uhd" ]; then
    git clone https://github.com/EttusResearch/uhd.git
fi
cd uhd/host
git checkout UHD-3.15.LTS
mkdir -p build
cd build
cmake -DCMAKE_CXX_FLAGS:STRING="-march=armv7-a -mfloat-abi=hard -mfpu=neon -mtune=cortex-a15 -Wno-psabi" \
      -DCMAKE_C_FLAGS:STRING="-march=armv7-a -mfloat-abi=hard -mfpu=neon -mtune=cortex-a15 -Wno-psabi" \
      -DCMAKE_ASM_FLAGS:STRING="-march=armv7-a -mfloat-abi=hard -mfpu=neon -mtune=cortex-a15" \
      -DCMAKE_BUILD_TYPE=Release ../
make -j$(nproc) install
ldconfig
EOF