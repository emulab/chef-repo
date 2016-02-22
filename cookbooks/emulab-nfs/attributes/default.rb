# Should be set in a role; only used in the default recipe
default['nfs']['server'] = nil
default['nfs']['dir'] = nil

# Attributes below are required for the community nfs cookbook to work
default['nfs']['mount']["options"] = "rw"

default['nfs']["packages"] = [ "portmap", "nfs-common", "nfs-kernel-server" ]

default['nfs']["port"]["statd"] = 32765
default['nfs']["port"]["statd_out"] = 32766 
default['nfs']["port"]["mountd"] = 32767
default['nfs']["port"]["lockd"] = 32768
    
default['nfs']["export"]["network"] = "10.0.0.0/8"
default['nfs']["export"]["writeable"] = true
default['nfs']["export"]["sync"] = true
default['nfs']["export"]["options"] = [ "no_root_squash" ]
