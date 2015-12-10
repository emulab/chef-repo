#
# Cookbook Name:: emulab-R
# Recipe:: default
#

if node['kernel']['machine'] == 'aarch64'
  include_recipe "emulab-R::aarch64"
else
  # Assuming x86
  include_recipe "emulab-R::x86"
end
