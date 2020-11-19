#!/bin/bash
# Copyright (c) 2019-2020 Advanced Micro Devices, Inc. All rights reserved.

omb_src=$PWD

# Build and Install UCX
cd ~
git clone https://github.com/openucx/ucx.git
cd ucx
git checkout v1.9.0
./autogen.sh
mkdir build && cd build
../contrib/configure-opt --prefix=/opt/rocm/ucx --with-rocm=/opt/rocm
make -j
sudo make -j install

# Build and Install OpenMPI
cd ~
git clone https://github.com/open-mpi/ompi.git
cd ompi
git checkout v4.0.5
git submodule update --init --recursive
./autogen.pl
mkdir build && cd build
../configure --prefix=/opt/rocm/ompi --with-ucx=/opt/rocm/ucx --disable-verbs
make -j
sudo make -j install

# Build and Install hipOMB
cd $omb_src
./autogen.sh
./configure --prefix=/opt/rocm/omb --enable-rocm --with-rocm=/opt/rocm \
    CC=/opt/rocm/ompi/bin/mpicc CXX=/opt/rocm/ompi/bin/mpicxx
make -j
sudo make -j install

