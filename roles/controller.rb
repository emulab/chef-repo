name "controller"
description "Role applied to the cluster controller nodes"
override_attributes(
  "nfs" => {
    "server" => "x-node-0",
    "dir" => "/exp-share"
  },
  "slurm" => {
    "control_machine" => "x-node-0",
    "control_addr" => "10.10.1.1",
    "node_list" => "x-node-[0-23]"
  }  
)
run_list [ "emulab-env",
           "emulab-nfs", 
           "emulab-slurm::default", 
           "emulab-slurm::accounting", 
           "emulab-slurm::example", 
           "emulab-openmpi",
           "emulab-petsc",
           "emulab-hpgmg" ]
