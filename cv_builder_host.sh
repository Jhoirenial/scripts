#!/usr/bin/env bash

OPENCV_PATH=opencv-4.0.1
ARCHITECTURE="x86_64"
BUILD_PATH=build_${ARCHITECTURE}


sudo apt-get install cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install python-dev python-numpy python3-dev python3-numpy libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libjasper-dev libdc1394-22-dev
sudo apt-get install gstreamer1.0-plugins-base gstreamer1.0-plugins-base-dbg

build_ocv()
{
    local build_type=${1}
    local build_dir=build_${ARCHITECTURE}_${build_type}

    mkdir -p ${build_dir}
    cd ${build_dir}
    mkdir -p installation

    cmake -D CMAKE_BUILD_TYPE=${build_type}   \
        -D CMAKE_INSTALL_PREFIX=installation \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules   \
        -D BUILD_OPENCV_PYTHON2=ON  \
        -D BUILD_OPENCV_PYTHON3=ON  \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D INSTALL_C_EXAMPLES=ON \
        -D BUILD_TESTS=OFF \
        -D BUILD_EXAMPLES=ON \
        -D WITH_TBB=ON \
        -D BUILD_TBB=ON \
        ..

    echo "----- Starting compilation"
    make -j8
    make install

    cd -
}

echo "----- Creating cross-compiled build directory structure"
cd ${OPENCV_PATH}
# CMAKE_BUILD_TYPE=Debug;Release
build_ocv Debug
build_ocv Release
