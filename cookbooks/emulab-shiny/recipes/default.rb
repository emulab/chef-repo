#
# Cookbook Name:: emulab-shiny
# Recipe:: default
#

if node['kernel']['machine'] == 'aarch64'
  Chef::Log.error("Node's architecture aarch64 is unsupported. Currently, Shiny on aarch64 needs to be built from source.")
  return
end

# Shiny requires R
include_recipe "emulab-R"

bash 'Install R shiny package' do
  code <<-EOH
    R -e "install.packages('shiny', repos='https://cran.rstudio.com/')"
  EOH
  # Maybe it is already istalled?
  not_if { ::File.directory?("/usr/local/lib/R/site-library/shiny") }
end

package 'gdebi-core'

# Download the specified package
remote_file '/tmp/shiny-server.deb' do
  source "#{node['shiny']['package_URL']}"
  checksum "#{node['shiny']['checksum']}"
end

# Install (and launch) the downloaded package
bash 'Install shiny server using gdebi' do
  code <<-EOH
    echo "y\n" | gdebi /tmp/shiny-server.deb
  EOH
  # Maybe it is already running?
  not_if "status shiny-server | grep running"
end
