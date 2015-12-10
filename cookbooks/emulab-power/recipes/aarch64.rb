#
# Cookbook Name:: emulab-power
# Recipe:: aarch64
#
#

# Check if the kernel is already updated to the specified version
if node['kernel']['release'] == node["power_arm"]["kernel_version"]
  log "Kernel has been patched already - version #{node["power_arm"]["kernel_version"]}"

  execute "apt-get update" 
  apt_package "i2c-tools" 
  apt_package "freeipmi" 

  log "Load i2c_dev module"
  execute "modprobe i2c-dev" 

  log "Create a test script in /tmp"
  template "/tmp/on-node-power.sh" do
    source "on-node-power.sh.erb"
  end
else
  # download the tarball (or use exisiting one if the checksum matches)
  remote_file node["power_arm"]["kernel_tar"] do
    source node["power_arm"]["kernel_url"]
    checksum node["power_arm"]["kernel_checksum"]
  end
  
  # make a backup copy of /boot
  execute "cp -r /boot /boot.BACKUP" do
    not_if { ::File.exists?('/boot.BACKUP') }
  end
  
  # extract the tarball into /boot
  execute "tar xf #{node["power_arm"]["kernel_tar"]}" do
    cwd '/boot'
  end
  
  directory node["power_arm"]["i2c_module_dir"]
  
  # obtain tarball with i2c module
  remote_file node["power_arm"]["i2c_module_tar"] do
    source node["power_arm"]["i2c_module_url"]
  end
  
  # extract the tarball 
  execute "tar xf #{node["power_arm"]["i2c_module_tar"]}" do
    cwd node["power_arm"]["i2c_module_dir"]
  end
  
  # Make sure that i2c-dev loads after reboot
  execute "echo i2c-dev >> /etc/modules"
  
  # Boot into the new kernel
  execute "reboot" 
end
