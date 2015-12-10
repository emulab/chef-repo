#
# Cookbook Name:: emulab-power
# Recipe:: default
#
#

if node['kernel']['machine'] == 'aarch64'
  include_recipe "emulab-power::aarch64"
else
  # Assuming x86
  include_recipe "emulab-power::x86"
end
