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
  trget = node["apachebench"]["target_host"]
end

log "Benchmarking #{target}"

# Default values for these attributes are specified inside attributes/default.rb
ports = node["apachebench"]["ports"]
n = node["apachebench"]["request_number"]
c = node["apachebench"]["request_concurrent"]
out = node["apachebench"]["output"]

# Function for checkng if there is a service listening on a given port
def port_listening?(port)
  system("lsof -i:#{port}", out: '/dev/null')
end

ports.each do |port|
  if port_listening?(port)
    if port == 443
      url = "https://#{target}:#{port}/"
    else
      url = "http://#{target}:#{port}/"
    end

    # Run the benchmark (via calling a shell command)
    execute "ab -n #{n} -c #{c} -g #{out}.#{port} #{url}"
    ignore_failure true

    # Create a gnuplot script for processing this specific output (using a temlate)
    template "#{out}.#{port}-plot" do
      source "apachebench-plot"
      variables(
        :input  => "#{out}.#{port}",
        :output  => "#{out}.#{port}.png" )
    end

    # Plot the output using the created script
    execute "gnuplot #{out}.#{port}-plot"
  
    # Check that apache is installed (via checking the attribute) and the docroot_dir is set 
    if node.exists?("apache") && node["apache"].exists?("docroot_dir")  
      # Copy the created graph to the apache's document root
      remote_file "Publish the graph" do 
        path "#{node['apache']['docroot_dir']}/#{target}-#{port}.png" 
        source "file://#{out}.#{port}.png"
      end
    end

  else
    log "Nothing is listening on the port #{port}. Skipping benchmarking for that port."
  end
end
