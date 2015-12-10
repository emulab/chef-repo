#
# Cookbook Name:: emulab-env
# Recipe:: packages
#

# Run apt-get update
execute "apt-get update" do
  action :nothing
end.run_action(:run)

# Install common packages
package "screen" 
package "vim"
package "git" 
package "wget"
package "build-essential"
