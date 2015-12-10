#
# This role depends on the emulab-nfs cookbook;
# emulab-nfs depends on the nfs cookbook
# available at: https://supermarket.chef.io/cookbooks/nfs
# Make sure it is installed; If is not, try: knife cookbook site install nfs
#
name "nfs_client"
description "Role applied to the system(s) that should act as NFS client(s)."
override_attributes(
  "nfs" => {
    "mount" => {
      "dir" => "/exp-share",
      "source" => "x-node-0:/exp-share",
      "options" => "rw"
    }  
  }
)
run_list [ "emulab-nfs::mount" ]
