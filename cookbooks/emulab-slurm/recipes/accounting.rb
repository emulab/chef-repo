#
# Cookbook Name:: emulab-slurm
# Recipe:: accouting
#

# Only install accounting on the head node
if node['hostname'] == node["slurm"]["control_machine"]

  log "This node was selected to be the SLURM control machine (head node)"

  log "Installing mysql for accounting"
  # configuration should be in: /etc/mysql-slurm/my.cnf
  # control via: service mysql-slurm start|stop|status|restart
  mysql_service 'slurm' do
    port node["slurm"]['mysql_port']
    version node["slurm"]['mysql_version']
    initial_root_password node["slurm"]['mysql_root_pass']
    action [:create, :start]
  end
  
  log "Make mysql-slurm used by default"
  directory '/etc/mysql' do
    action :delete
    recursive true
  end
  directory '/var/run/mysqld' do
    action :delete
    recursive true
  end
  link '/etc/mysql' do
    to '/etc/mysql-slurm'
  end
  link '/var/run/mysqld' do
    to '/var/run/mysql-slurm'
  end
  
  template "/tmp/mysql-init.sql" do
    source "mysql-init.sql.erb"
    variables(
      :user => node["slurm"]["mysql_slurm_user"],
      :pass => node["slurm"]["mysql_slurm_pass"],
      :port => node["slurm"]["mysql_port"],
      :db => node["slurm"]["mysql_slurm_db"]
    )
  end
 
  bash 'Creating database, creating user, granting permissions (if database doesnt exist already)' do
  code <<-EOH
    echo "show databases" | mysql -u root -p#{node["slurm"]['mysql_root_pass']} | grep #{node["slurm"]["mysql_slurm_db"]}
    if [ "$?" == 1 ] ; then
      mysql -u root -p#{node["slurm"]['mysql_root_pass']} < /tmp/mysql-init.sql 
    fi
    EOH
  end

  log "Installing mysql client" 
  mysql_client 'default' do
    action :create
  end
  
  log "Installing slurmdbd for accounting"
  package "slurm-llnl-slurmdbd"

  log "Creating slurmdbd.conf from a template"
  template "#{node['slurm']['confdir']}/slurmdbd.conf" do
    source "slurmdbd.conf.erb"
    mode "0644"
    variables(
      :user => node["slurm"]["user"],
      :db_port => node["slurm"]["mysql_port"],
      :db_user => node["slurm"]["mysql_slurm_user"],
      :db_pass => node["slurm"]["mysql_slurm_pass"],
      :db => node["slurm"]["mysql_slurm_db"]
    )
  end
 
  service "slurm-llnl-slurmdbd" do
    action [ :enable, :start ]
  end

  bash 'Setting up accounting' do
  code <<-EOH
    sacctmgr show cluster | grep #{node["slurm"]["cluster_name"]}
    if [ "$?" == 1 ] ; then
      sacctmgr -i -Q add cluster #{node["slurm"]["cluster_name"]}
    fi
    sacctmgr show account | grep #{node["slurm"]["account_name"]}
    if [ "$?" == 1 ] ; then
      sacctmgr -i -Q add account #{node["slurm"]["account_name"]} Description='Unlimited account for benchmarking' Organization=default
    fi
    sacctmgr show user | grep #{node["slurm"]["user"]} 
    if [ "$?" == 1 ] ; then
      sacctmgr -i -Q add user #{node["slurm"]["user"]} DefaultAccount=#{node["slurm"]["account_name"]} Partition=#{node["slurm"]["partition_name"]}
    fi
    EOH
  end

  log "Restarting service to apply modifications"
  services = %w[slurm-llnl slurm-llnl-slurmdbd]
  services.each do |service|
    service "#{service}" do
      action [ :restart ]
    end
  end
  
end
