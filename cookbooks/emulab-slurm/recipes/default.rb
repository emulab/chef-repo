#
# Cookbook Name:: emulab-slurm
# Recipe:: deafult
#

include_recipe 'apt'

packages = %w[slurm-llnl munge]
packages.each do |package|
  package "#{package}" do
    action :install
  end
end

# Create home dir for slurm user
directory "/home/#{node["slurm"]["user"]}" do
  owner node["slurm"]["user"]
  group node["slurm"]["group"]
end

# Update user
user node["slurm"]["user"] do
  shell "/bin/bash"
  home "/home/#{node["slurm"]["user"]}"
end

# Use munge key from files/ 
cookbook_file "/etc/munge/munge.key" do
  source "munge.key"
  mode "0400"
  owner "munge"
  group "munge"
end

# Create the slurm.conf file
template "#{node['slurm']['confdir']}/slurm.conf" do
  source "slurm.conf.erb"
  mode "0644"
  variables(
    :control_machine => node["slurm"]["control_machine"],
    :control_addr => node["slurm"]["control_addr"],
    :node_list => node["slurm"]["node_list"],
    :partition_name => node["slurm"]["partition_name"],
    :cluster_name => node["slurm"]["cluster_name"] )
end

# Set sticky bit on /var/log
directory "/var/log" do
  owner "root"
  group "syslog"
  mode 01755
  action :create
end

# Create log directory
directory "/var/log/slurm" do
  owner node["slurm"]["user"] 
  group node["slurm"]["group"]
  mode 00755
  action :create
end

services = %w[munge slurm-llnl]
services.each do |service|
  service "#{service}" do
    action [ :enable, :start ]
  end
end
