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

bash 'Install gridExtra' do
  code <<-EOH
    R -e "install.packages('gridExtra', repos='https://cran.rstudio.com/')"
  EOH
  not_if { ::File.directory?("/usr/local/lib/R/site-library/gridExtra") }
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
directory node['powervis']['logs_dir'] do
  mode '0755'
end

template "#{node['powervis']['logs_dir']}/random_sample.csv" do
  source 'SAMPLE.erb'
  mode 0644
  # Only add this sample if the dir is empty (two entries are "." and "..")
  only_if { ::Dir.entries(node['powervis']['logs_dir']).size <= 2 }
end

# Integration with apache2 for publishing data sets

# Install apache2 using apache2 cookbook
node.override["apache"]["listen"]= %w(8080)
node.override["apache"]['default_site_port']= "8080"
node.override['apache']['default_site_enabled']= true
node.override['apache']['docroot_dir']= "/var/www"
include_recipe "apache2"
include_recipe "apache2::mod_autoindex"

# Make /var/www/html usable by shiny
group "www-data" do
  action :modify
  members "shiny"
  append true
end
directory node["apache"]["docroot_dir"] do
  mode '774'
  group 'www-data'
end
# Strangely, html dir is needed; otherwise shiny can't save datasets
directory "#{node['apache']['docroot_dir']}/html" do
  mode '774'
  group 'www-data'
end

# Show index by default instead of the default index.html
file "#{node['apache']['docroot_dir']}/index.html" do
  action :delete
end
