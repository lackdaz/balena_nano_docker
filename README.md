# Balena-compatible Dockerfiles for Jetson Nano

## Introduction

This repository contains Dockerfiles and auxiliary scripts that can be used to create balena-compatible Docker images for Jetson Nano.
The contribution of this repo is `Dockerfile.tensorrt`, which is used for running Python-based apps that make use of accelerated inference.
The other Dockerfiles originate from the following repository: https://github.com/balena-io-projects/jetson-nano-sample-app/tree/master. 

## `Dockerfile.tensorrt`

1) Install NVIDIA SDK & download all packages for the Jetson NANO. Do not flash the board from SDK manager.
2) run `./prepare.sh <path_to_sdk_downloads_dir>`
3) Build `Dockerfile.tensorrt`.
4) Run the Docker image on a Jetson Nano in privileged mode, e.g.: `docker run -it --rm --privileged <image-name> bash`.

The size of this image is about 3.5 GB, mainly due to the CUDA runtime libraries.

## `Dockerfile.cudasamples`

1) Install NVidia SDK & download all packages for the Jetson NANO. Do not flash the board from SDK manager.
2) run ./prepare.sh <path_to_sdk_downloads_dir>
3) Build Dockerfile.cudasamples
4) In the app container, start the X display server and run the prebuilt sample apps:
    $ X &
    $ ./clock
    $ ./deviceQuery
    $ ./postProcessGL
    $ ./simpleGL
    $ ./simpleTexture3D
    $ ./smokeParticles

NOTE: CUDA runtime libraries are very large, some even reaching 100-250MB. Therefore not all sample apps have been built in order to keep image size low.
To build more examples please add them to the samples section of the Dockerfile.

If headless GPU computing needs to be performed, without CUDA runtime and without using a display, comment out the path of runtime libs as mentioned in the docker file and remove xorg from the final image.
A GPU API only image can be cut down to less than 400 MB. With CUDA libraries installed the image size goes slighthly over 800 MB whereas an image with video output support - X display server and goes at around 1.3 GB.

## `Dockerfile.opencv`

This dockerfile presents how OpenCV can be built with CUDA libraries inside a container.
a) Perform steps 1) and 2) from above but remove libcudnn debs to improve upload time
b) Build Dockerfile.opencv
c) In the app container run
   $ export DISPLAY=:0
   $ ./example_ximgproc_fourier_descriptors_demo
   $ ./example_ximgproc_paillou_demo corridor.jpg

NOTE: This example builds only a small subset of OpenCV & CUDA modules to keep build time and image size at a low point.
Building specific OpenCV modules is done by selecting them in the build args: cmake -D BUILD_LIST=module1,module2.
Depending on specific usecase, select modules may need to be added as dependencies, otherwise OpenCV build may fail.

In this format the resulting build image is around 1.05 GB.
# balena_nano_docker
