#!/usr/bin/env bash

OPENCV_PATH=opencv-4.0.1
ARCHITECTURE="arm-linux-gnueabihf"
BUILD_PATH=build_${ARCHITECTURE}

# run on target
# sudo apt-get install python-dev python-numpy python3-dev python3-numpy
# sudo apt-get install libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev

echo "----- Creating cross-compiled build directory structure"

cd ${OPENCV_PATH}

# make clean

export PATH=/home/michael/iXM/gcc-linaro-7.3.1-2018.05-x86_64_arm-linux-gnueabihf/bin:$PATH
# export SYSROOT=/home/michael/iXM/remote_sysroot
# PKG_CONFIG="PKG_CONFIG_PATH=${SYSROOT}/usr/lib/*/pkgconfig/ PKG_CONFIG_SYSROOT_DIR=${SYSROOT} pkg-config"
# LDFLAGS="${LDFLAGS} --sysroot=${SYSROOT} -L${SYSROOT}/usr/lib/*"

export SYSROOT=/home/michael/iXM/remote_sysroot
# export PKG_CONFIG_DIR=
# export PKG_CONFIG_LIBDIR=${SYSROOT}/usr/lib/pkgconfig:${SYSROOT}/usr/share/pkgconfig:${SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig
# # export PKG_CONFIG_LIBDIR=${SYSROOT}
# export PKG_CONFIG_SYSROOT_DIR=${SYSROOT}

# export PKG_CONFIG_PATH=${SYSROOT}/usr/lib/arm-linux-gnueabihf/pkgconfig

build_ocv()
{
    local build_type=${1}
    local build_dir=build_${ARCHITECTURE}_${build_type}

    mkdir -p ${build_dir}
    cd ${build_dir}
    mkdir -p installation

    cmake -D CMAKE_BUILD_TYPE=${build_type}   \
        -D CMAKE_INSTALL_PREFIX=installation \
        -D CMAKE_TOOLCHAIN_FILE=../platforms/linux/arm-gnueabi.toolchain.cmake \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules   \
        -D BUILD_OPENCV_PYTHON2=OFF  \
        -D BUILD_OPENCV_PYTHON3=OFF  \
        -D INSTALL_C_EXAMPLES=ON \
        -D BUILD_TESTS=OFF \
        -D BUILD_EXAMPLES=ON \
        -D WITH_TBB=OFF \
        -D BUILD_TBB=OFF \
        -D WITH_IPP=OFF \
        -D ENABLE_NEON=ON \
        -D CPU_BASELINE="NEON" \
        ..

    echo "----- Starting compilation"

    make -j8 && make install

    cd -
}

build_ocv Release
build_ocv Debug
