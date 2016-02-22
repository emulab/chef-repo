#
# Cookbook Name:: emulab-apachebench
# Recipe:: default
#

# Install the package with the benchmark 
package "apache2-utils" 
# Install gnuplot for plotting benchmark output
package "gnuplot"

# If the target_host attribute is not set (e.g., from a role), benchmark local host 
if node["apachebench"]["target_host"].nil?
  target = node["fqdn"]
else
  target = node["apachebench"]["target_host"]
end

log "Benchmarking #{target}"

# Default values for these attributes are specified inside attributes/default.rb
ports = node["apachebench"]["ports"]
n = node["apachebench"]["request_number"]
c = node["apachebench"]["request_concurrent"]
out = node["apachebench"]["output"]

ports.each do |port|
  if port == 443
    url = "https://#{target}:#{port}/"
  else
    url = "http://#{target}:#{port}/"
  end

  output_file = "#{out}.#{port}"
  # To avoid possible confusion, delete the version of the output file if it exists
  file output_file do
    action :delete
  end
    
  # Run the benchmark (via calling a shell command)
  execute "ab -n #{n} -c #{c} -g #{output_file} #{url}" do
    ignore_failure true
  end

  plot_script = "#{output_file}-plot"
  graph_file = "#{output_file}.png" 

  # Create a gnuplot script for processing this specific output (using a template)
  template plot_script do
    source "apachebench-plot"
    variables(
      :input  => output_file,
      :output  => graph_file )
  end

  # Plot the output using the created script
  execute "gnuplot #{plot_script}" do
    ignore_failure true
  end
  
  # Check that apache is installed (via checking the attribute) and the docroot_dir is set 
  if (not node["apache"].nil?) && (not node["apache"]["docroot_dir"].nil?)  
    # Copy the created graph to the apache's document root
    remote_file "Publish the graph" do 
      path "#{node['apache']['docroot_dir']}/#{target}-#{port}.png" 
      source "file://#{graph_file}"
      ignore_failure true
    end
   
    # Default index.html prevents seeing the directory listing; rename it if it exists (make copy and delete)
    index_file = "#{node['apache']['docroot_dir']}/index.html"
    backup_copy = "#{node['apache']['docroot_dir']}/index-backup.html" 
    remote_file "Making a copy of index.html" do
      path backup_copy 
      source "file://#{index_file}"
      only_if { ::File.exists?(index_file) }
    end
    file index_file do
      action :delete
      only_if { ::File.exists?(index_file) }
    end
  end
end
