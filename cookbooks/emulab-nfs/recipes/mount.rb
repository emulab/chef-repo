#
# Cookbook Name:: nfs
# Recipe:: mount
#
# Custom recipe distributed along with other artifacts in the Emulab's Chef Repoistory	
# For more info, see: https://github.com/emulab/chef-repo

# Run configuration from the recipe in the dependency cookbook
include_recipe 'nfs::default'

directory node['nfs']['dir'] do
  action :create
end

mount node['nfs']['dir'] do
  device "#{node['nfs']['server']}:#{node['nfs']['dir']}"
  fstype 'nfs'
  options node['nfs']['mount']['options']
  action [:mount, :enable]
end
