#
# Cookbook Name:: emulab-R
# Recipe:: aarch64
#

# Package built for aarch64 needs new GCC
include_recipe "emulab-gcc"

deb_tmp = "/tmp/R.deb"

# Download R package
remote_file deb_tmp do
  source "#{node['R']['aarch64_package']}"
  not_if { ::File.exist?(deb_tmp) }
end

# Install
dpkg_package 'OpenMPI' do
  source deb_tmp
end
