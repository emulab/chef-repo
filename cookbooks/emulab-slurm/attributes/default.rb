default["slurm"]["confdir"] = "/etc/slurm-llnl"
default["slurm"]["user"] = "slurm"
default["slurm"]["uid"] = "1002"
default["slurm"]["group"] = "slurm"
default["slurm"]["gid"] = "1001"
default["slurm"]["partition_name"] = "all"
default["slurm"]["cluster_name"] = "default"
default["slurm"]["account_name"] = "perf"

# This is where example will be installed
default["slurm"]["scratch"] = "/scratch"

# Attributes for accounting configuration
default["slurm"]["mysql_root_pass"] = "Ch@ngeMePle@se!"
default["slurm"]["mysql_port"] = "3306"
default["slurm"]["mysql_version"] = "5.5"
default["slurm"]["mysql_slurm_user"] = "slurm_user"
default["slurm"]["mysql_slurm_pass"] = "ChangeMeAsWell!:)" 
default["slurm"]["mysql_slurm_db"] = "slurm_db"

# Following attributes must be defined in roles or environments (no good defaults)
default["slurm"]["node_list"] = nil
default["slurm"]["control_machine"] = nil
default["slurm"]["control_addr"] = nil
