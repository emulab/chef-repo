#
# Cookbook Name:: emulab-powervis
# Recipe:: default
#

if node['kernel']['machine'] == 'aarch64'
  Chef::Log.error("Currently, powervis doesn't work on aarch64 (dependencies are missing).")
  return
end

# powervis dashboard needs shiny; emulab-shiny will call emulab-R
include_recipe "emulab-shiny"

package "git"

bash 'Install ggplot2, required by powervis - might take some time' do
  code <<-EOH
    R -e "install.packages('ggplot2', repos='https://cran.rstudio.com/')"
  EOH
  not_if { ::File.directory?("/usr/local/lib/R/site-library/ggplot2") }
end

# Delete the default app (what is in /srv/shiny-server, unless that dir already contains powervis
directory '/srv/shiny-server' do
  recursive true
  action :delete
  not_if { ::File.directory?("/srv/shiny-server/powervis") }
end

# Clone the repo specified in the attributes file
git '/srv/shiny-server' do
  repository node['powervis']['repo']
  action :checkout
  not_if { ::File.directory?("/srv/shiny-server/powervis") }
end

# Optional: add a sample of power data in /var/log/power so the dashboard doesn't return an error
directory "/var/log/power"
template "/var/log/power/SAMPLE.csv" do
  source 'SAMPLE.erb'
  mode 0644
end
