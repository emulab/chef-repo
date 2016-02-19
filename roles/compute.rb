name "compute"
description "Role applied to the cluster compute nodes"
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
run_list [ "emulab-nfs", 
           "emulab-slurm",
           "emulab-openmpi" ]
