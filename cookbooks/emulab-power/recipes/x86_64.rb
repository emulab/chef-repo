#
# Cookbook Name:: emulab-power
# Recipe:: x86_64
#
#

log "Running x86_64-specific recipe"

# Prerequisites
apt_package "freeipmi"
apt_package "openipmi"
execute "modprobe ipmi_devintf"

# Create a directory for logger scripts
logger_dir = node["power_x86"]["logger_dir"]
directory logger_dir

# Create the logger script from a template and install it
logger_path = "#{logger_dir}/x86_64-logger.sh" 
template logger_path do
  source 'x86_64-logger.sh.erb'
  mode 0744
  owner 'root'
  group 'root'
  variables(
    :dest_dir => node["power_x86"]["logs_dir"],
    :sample_interval_sec => node["power_x86"]["sample_interval_sec"],
    :sample_limit => node["power_x86"]["sample_limit"]
  )
end

# Create directory for power logs
directory node["power_x86"]["logs_dir"] do
  mode '0755'
end

# Start the logger in the background (if no pid file is present)

bash 'logger' do
  code <<-EOH
    bash #{logger_path} &
    echo $! > #{node['power_x86']['logger_pid_file']}
  EOH
  not_if { ::File.exist?(node["power_x86"]["logger_pid_file"]) }
end

log "Power logger should be running now. pid file: #{node['power_x86']['logger_pid_file']}. log dir: #{node['power_x86']['logs_dir']}"
log "If logger is not running, remove the pid file and rerun the cookbook"
