#
# Cookbook Name:: emulab-openmpi
# Recipe:: default
#

# Needs new GCC
include_recipe "emulab-gcc"

if node['kernel']['machine'] == 'aarch64'
  openmpi_package_URL=node['openmpi']['aarch64_URL']
else
  # Assuming x86
  openmpi_package_URL=node['openmpi']['x86_URL']
end 

Chef::Log.info( "Using OpenMPI tarball: #{openmpi_package_URL}")

deb_tmp = "/tmp/openmpi.deb"
# This is where the deb package installs openmpi by default 
# (this location was selected with 'configure --prefix=...' before packaging)
default_dest = "/opt/openmpi"

# Create dir if necessary
directory node['openmpi']['root_level_dir'] 

# Download the appropriate package
remote_file deb_tmp do
  source openmpi_package_URL
  not_if { ::File.exist?(deb_tmp) }
end

# Install
dpkg_package 'OpenMPI' do
  source deb_tmp
end

execute "Move OpenMPI to the specified location" do
  command "mv #{default_dest} #{node['openmpi']['root_level_dir']}"
  not_if { ::File.exist?("#{node['openmpi']['root_level_dir']}/openmpi") }
end

# Make OpenMPI usable
template node['openmpi']['profile'] do
  source 'openmpi.erb'
  variables(
    :openmpi_base       => "#{node['openmpi']['root_level_dir']}/openmpi"
  )
  not_if { ::File.exist?(node['openmpi']['profile']) }
end
bash 'Source the new OpenMPI profile' do
  code <<-EOH
    source "#{node['openmpi']['profile']}"
    EOH
  only_if { ::File.exists?(node['openmpi']['profile']) }
end

# Optional: create symlink from /opt to the real location 
link "/opt/openmpi" do
  to "#{node['openmpi']['root_level_dir']}/openmpi"
  not_if { ::File.exist?("/opt/openmpi") }
end
