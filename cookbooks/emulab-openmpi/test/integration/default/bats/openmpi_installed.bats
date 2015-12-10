#!/usr/bin/env bats

MIN_VERSION=500

setup() {
  source /etc/profile

  mpicc_version=`mpicc --version | head -1 | awk '{print $4}' | sed 's/\.//g'`
  mpicc_version_ok=0; [ $mpicc_version -ge $MIN_VERSION ] && mpicc_version_ok=1 

  # Raw command:
  # # mpicc --version
  # mpicc (Ubuntu 5.2.1-23ubuntu1~14.04.2) 5.2.1 20151031
  # Copyright (C) 2015 Free Software Foundation, Inc.
  # This is free software; see the source for copying conditions.  There is NO
  # warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  #
  # Filtered output:
  # 521
  
  gpp_version=`mpic++ --version | head -1 | awk '{print $4}' | sed 's/\.//g'`
  gpp_version_ok=0; [ $gpp_version -ge $MIN_VERSION ] && gpp_version_ok=1 
  
  mpif_version=`mpifort --version | head -1 | awk '{print $5}' | sed 's/\.//g'`
  mpif_version_ok=0; [ $mpif_version -ge $MIN_VERSION ] && mpif_version_ok=1 
}

@test "mpicc is found" {
  run which mpicc
}
@test "mpicc is above version: $MIN_VERSION" {
  [ $mpicc_version_ok -eq 1 ]
}

@test "mpic++ is found" {
  run which mpic++
}
@test "mpic++ is above version: $MIN_VERSION" {
  [ $gpp_version_ok -eq 1 ]
}

@test "mpifort is found" {
  run which mpifort
}
@test "mpifort is above version: $MIN_VERSION" {
  [ $mpif_version_ok -eq 1 ]
}
