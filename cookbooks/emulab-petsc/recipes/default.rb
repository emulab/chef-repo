#
# Cookbook Name:: emulab-petsc
# Recipe:: default
#

git "#{node['petsc']['root_level_dir']}/petsc-src" do
 repository node['petsc']['repo']
 action :checkout
end

directory "#{node['petsc']['root_level_dir']}/petsc"

log 'Now building PETSc - this might take a long time'
bash 'PETSC: configure, make, install' do
  code <<-EOH
    source /etc/profile
    ./configure --with-debugging=0 --prefix="#{node['petsc']['root_level_dir']}/petsc" --download-f2cblaslapack=1 --with-shared-libraries=0 2>&1 > .configure.log 
    make MAKE_NP=#{node["cpu"]["total"]} all 2>&1 > .make.all.log
    make install 2>&1 > .make.install.log
    touch "#{node['petsc']['root_level_dir']}/petsc/.completed"
  EOH
  cwd "#{node['petsc']['root_level_dir']}/petsc-src"
  not_if { File.exists?("#{node['petsc']['root_level_dir']}/petsc/.completed") }
end
