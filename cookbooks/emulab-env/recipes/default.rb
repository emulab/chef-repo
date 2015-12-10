#
# Cookbook Name:: emulab-env
# Recipe:: default
#

include_recipe "emulab-env::packages"
include_recipe "emulab-env::templates"
include_recipe "emulab-env::email"
