#
# Cookbook Name:: emulab-anaconda
# Recipe:: default
#

node.default['anaconda']['accept_license'] = 'yes'
node.default['anaconda']['notebook']['ip'] = 'localhost'
node.default['anaconda']['notebook']['port'] = 8888

include_recipe "anaconda::default"
include_recipe "anaconda::notebook_server"
