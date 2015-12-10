#
# Cookbook Name:: emulab-env
# Recipe:: templates
#

# Install common and useful aliases and a better prompt
template "/etc/profile.d/emulab-profile.sh" do
  source 'profile.erb'
  mode 0644
  owner 'root'
  group 'root'
  only_if { ::File.directory?("/etc/profile.d/") }
end

# Appropriate configuration file for screen
template "/root/.screenrc" do
  source 'screenrc.erb'
  mode 0644
  owner 'root'
  group 'root'
end
