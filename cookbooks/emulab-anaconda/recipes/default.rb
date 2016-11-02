#
# Cookbook Name:: emulab-anaconda
# Recipe:: default
#

node.default['anaconda']['accept_license'] = 'yes'
node.default['anaconda']['notebook']['ip'] = 'localhost'
node.default['anaconda']['notebook']['port'] = 8888
node.default['anaconda']['notebook']['install_dir'] = '/opt/ipython/server'

include_recipe "anaconda::default"
include_recipe "anaconda::notebook_server"

# Optionally install jupyter notebook for power analysis
# Only do it if emulab-power is also included in run_list
if node.run_list?('recipe[emulab-power]')
  nb_path = "#{node.default['anaconda']['notebook']['install_dir']}/power_analysis.ipynb"
  template nb_path do
    source 'power_analysis.ipynb.erb'
    mode 0644
    owner 'anaconda'
    group 'anaconda'
  end
  log "Installed jupyter noteboot for power analysis at: #{nb_path}"
end
