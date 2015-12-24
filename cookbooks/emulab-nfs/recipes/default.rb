#
# Cookbook Name:: emulab-nfs
# Recipe:: default
#

if node['hostname'] == node["nfs"]["server"]
  include_recipe "emulab-nfs::export"
else
  include_recipe "emulab-nfs::mount"
end
