#
# Cookbook Name:: emulab-hpgmg
# Recipe:: default
#

git "#{node['hpgmg']['root_level_dir']}/hpgmg" do
 repository node['hpgmg']['repo']
 action :checkout
end

if node['kernel']['machine'] == 'aarch64' 
  flags=node['hpgmg']['HPGMG_CFLAGS-aarch64']
else
  flags=node['hpgmg']['HPGMG_CFLAGS-x86']
end

bash 'HPGMG: configure and make' do
  code <<-EOH
    source /etc/profile
    export PETSC_DIR=#{node['petsc']['root_level_dir']}/petsc PETSC_ARCH=build
    ./configure 2>&1 > .configure.log
    make HPGMG_CFLAGS='#{flags}' 2>&1 > .make.log
  EOH
  cwd "#{node['hpgmg']['root_level_dir']}/hpgmg"
end

log "To run HPGMG, try, for instance: mpiexec -n 4 --allow-run-as-root #{node['hpgmg']['root_level_dir']}/hpgmg/build/bin/hpgmg-fe sample -local 1e3,2e3 -op_type poisson2 -log_summary"
