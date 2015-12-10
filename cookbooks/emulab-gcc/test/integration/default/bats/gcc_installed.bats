#!/usr/bin/env bats

MIN_VERSION=500

setup() {
  gcc_version=`gcc --version | head -1 | awk '{print $4}' | sed 's/\.//g'`
  gcc_version_ok=0; [ $gcc_version -ge $MIN_VERSION ] && gcc_version_ok=1 

  # Raw command:
  # # gcc --version
  # gcc (Ubuntu 5.2.1-23ubuntu1~14.04.2) 5.2.1 20151031
  # Copyright (C) 2015 Free Software Foundation, Inc.
  # This is free software; see the source for copying conditions.  There is NO
  # warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  #
  # Filtered output:
  # 521
  
  gpp_version=`g++ --version | head -1 | awk '{print $4}' | sed 's/\.//g'`
  gpp_version_ok=0; [ $gpp_version -ge $MIN_VERSION ] && gpp_version_ok=1 
  
  gf_version=`gfortran --version | head -1 | awk '{print $5}' | sed 's/\.//g'`
  gf_version_ok=0; [ $gf_version -ge $MIN_VERSION ] && gf_version_ok=1 
}

@test "gcc is found" {
  run which gcc
}
@test "gcc is above version: $MIN_VERSION" {
  [ $gcc_version_ok -eq 1 ]
}

@test "g++ is found" {
  run which g++
}
@test "g++ is above version: $MIN_VERSION" {
  [ $gpp_version_ok -eq 1 ]
}

@test "gfortran is found" {
  run which gfortran
}
@test "gfortran is above version: $MIN_VERSION" {
  [ $gf_version_ok -eq 1 ]
}
