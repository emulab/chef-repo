#
# Cookbook Name:: emulab-power
# Recipe:: default
#
#

arch = node['kernel']['machine']

if arch == 'aarch64'
  include_recipe "emulab-power::aarch64"
elsif arch == "x86_64"
  include_recipe "emulab-power::x86_64"
else
  Chef::Log.error("Unsupported architecture: #{arch}. Exiting the cookbook")
end
