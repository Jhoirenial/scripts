#!/bin/bash

# # setup
# sudo apt-get install -y docker.io
# sudo usermod -a -G docker $USER
# # logout and login

mkdir -p ubuntu16_armhf_opencv
cp -f Dockerfile_armhf_opencv ubuntu16_armhf_opencv/Dockerfile

docker image build ubuntu16_armhf_opencv
# # is it necessary?
# docker tag 320b9da85f3b ubuntu16_armhf_opencv:latest

# docker run ubuntu16_armhf_opencv

# container_id=`docker container ls --all | grep ubuntu16_armhf_opencv | awk '{print $1}'`
# docker cp ${container_id}:/opencv/build_arm-linux-gnueabihf ./opencv_build_arm-linux-gnueabihf
