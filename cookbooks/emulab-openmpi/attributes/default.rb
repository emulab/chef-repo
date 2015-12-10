# This is the root-level directory where gcc will be installed
default['openmpi']['root_level_dir'] = "/exp-share"
# Profile, which will update paths to enable the new GCC
default['openmpi']['profile'] = "/etc/profile.d/emulab-openmpi.sh"

# x86
default['openmpi']['x86_URL'] = "https://s3-us-west-2.amazonaws.com/cloudlab-dev/openmpi_1.10.1-1_amd64.deb"
# aarch64
default['openmpi']['aarch64_URL'] = "https://s3-us-west-2.amazonaws.com/cloudlab-dev/openmpi_1.10.1-1_arm64.deb"
