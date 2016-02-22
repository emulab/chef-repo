#
# This role depends on the emulab-nfs cookbook;
# emulab-nfs depends on the nfs cookbook
# available at: https://supermarket.chef.io/cookbooks/nfs
# Make sure it is installed; If it is not, try: knife cookbook site install nfs
#
name "nfs"
description "Role applied to all NFS nodes - server and client"
override_attributes(
  "nfs" => {
    "server" => "head",
    "dir" => "/exp-share",
    "export" => {
      "network" => "10.0.0.0/8",
      "writeable" => true 
    }
  }
)
run_list [ "emulab-nfs" ]
