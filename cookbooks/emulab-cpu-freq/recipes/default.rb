#
# Cookbook Name:: emulab-cpu-freq
# Recipe:: default
#
#

if node['kernel']['machine'] == 'aarch64'
  include_recipe "emulab-cpu-freq::aarch64"
else
  # Assuming x86
  # include_recipe "emulab-cpu-freq::x86"
end
