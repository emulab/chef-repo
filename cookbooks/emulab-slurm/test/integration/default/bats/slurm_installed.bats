#!/usr/bin/env bats

@test "slurmd is running" {
  run "service slurm-llnl status | grep running | grep slurmd"
}
@test "slurmctld is running" {
  run "service slurm-llnl status | grep running | grep slurmctld"
}
@test "munge is running" {
  run "service munge status | grep slurmctld"
}
@test "mysql-slurm is running" {
  run "service mysql-slurm status| grep running"
}
@test "sinfo should show at least one idle node" {
  run "sinfo | grep idle"
}
