#
# Cookbook Name:: emulab-cpu-freq
# Recipe:: aarch64
#
#

# Check if the kernel is already updated to the specified version
if node['kernel']['release'] == node["cpu_freq_arm"]["kernel_version"]
  log "Kernel has been patched already - version #{node["cpu_freq_arm"]["kernel_version"]}"

  log "Load xgene-cpufreq module"
  execute "modprobe xgene-cpufreq" 

  log "Create executable script for setting frequency"
  template "/usr/local/bin/set_freq.sh" do
    source "set_freq.sh.erb"
    mode '0755'
  end
  
else
  # download the tarball (or use exisiting one if the checksum matches)
  remote_file node["cpu_freq_arm"]["kernel_tar"] do
    source node["cpu_freq_arm"]["kernel_url"]
    checksum node["cpu_freq_arm"]["kernel_checksum"]
  end
  
  # make a backup copy of /boot
  execute "cp -r /boot /boot.BACKUP" do
    not_if { ::File.exists?('/boot.BACKUP') }
  end
  
  # extract the tarball into /boot
  execute "tar xf #{node["cpu_freq_arm"]["kernel_tar"]}" do
    cwd '/boot'
  end
  
  directory node["cpu_freq_arm"]["modules_dir"]
  
  # obtain tarball with modules
  remote_file node["cpu_freq_arm"]["modules_tar"] do
    source node["cpu_freq_arm"]["modules_url"]
  end
  
  # extract the tarball 
  execute "tar xf #{node["cpu_freq_arm"]["modules_tar"]}" do
    cwd node["cpu_freq_arm"]["modules_dir"]
  end
  
  # Make sure that xgene-cpufreq loads after reboot
  execute "echo xgene-cpufreq >> /etc/modules"
  
  # Boot into the new kernel
  execute "reboot" 
end
