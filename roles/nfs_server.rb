#
# This role depends on the emulab-nfs cookbook;
# emulab-nfs depends on the nfs cookbook
# available at: https://supermarket.chef.io/cookbooks/nfs
# Make sure it is installed; If is not, try: knife cookbook site install nfs
#
name "nfs_server"
description "Role applied to the node that should be an NFS server."
override_attributes(
  "nfs" => {
    "packages" => [ "portmap", "nfs-common", "nfs-kernel-server" ],
    "port" => {
      "statd" => 32765,
      "statd_out" => 32766,
      "mountd" => 32767,
      "lockd" => 32768
    },
    "export" => {
      "dir" => "/exp-share",
      "network" => "10.0.0.0/8",
      "writeable" => true,
      "sync" => true,
      "options" => [ "no_root_squash" ]
    }  
  }
)
run_list [ "emulab-nfs::export" ]
