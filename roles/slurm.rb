name "slurm"
description "Role applied to the nodes in a SLURM cluster (head or compute)"
override_attributes(
  "slurm" => {
    "control_machine" => "x-node-0",
    "control_addr" => "10.10.1.1",
    "node_list" => "x-node-[0-23]"
    }  
)
run_list [ "emulab-slurm::default", "emulab-slurm::accounting", "emulab-slurm::example" ]
