#!/bin/bash
# Copyright (c) 2019-2020 Advanced Micro Devices, Inc. All rights reserved.

set -x
export OMPI_ALLOW_RUN_AS_ROOT=1
export OMPI_ALLOW_RUN_AS_ROOT_CONFIRM=1

mpi_dir=/opt/rocm/ompi
omb_dir=/opt/rocm/omb
p2p_dir=$omb_dir/libexec/osu-micro-benchmarks/mpi/pt2pt
p2p_opt='-d rocm D D'
coll_dir=$omb_dir/libexec/osu-micro-benchmarks/mpi/collective
coll_opt='-d rocm'
mpi_opt=''

$mpi_dir/bin/mpirun -n 2    $mpi_opt   $p2p_dir/osu_latency          $p2p_opt
$mpi_dir/bin/mpirun -n 2    $mpi_opt   $p2p_dir/osu_bw               $p2p_opt

$mpi_dir/bin/mpirun -n 2    $mpi_opt   $coll_dir/osu_bcast           $coll_opt
$mpi_dir/bin/mpirun -n 2    $mpi_opt   $coll_dir/osu_allreduce       $coll_opt
$mpi_dir/bin/mpirun -n 2    $mpi_opt   $coll_dir/osu_alltoall        $coll_opt
