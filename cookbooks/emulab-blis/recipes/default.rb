#
# Cookbook Name:: emulab-blis
# Recipe:: default
#

log 'Architecture check' do
  message "Attribute [\"blis\"][\"acrhitecture\"] is not set. Set it in a role or environment file."
  level :error
  only_if { node['blis']['architecture'] == nil }
end

# More on BLIS harwdare support: https://github.com/flame/blis/wiki/HardwareSupport

# Technically, BLIS can be built with the default GCC
# However, in order to make sure that all current optimizations are used,
# the new version of GCC should be used
include_recipe "emulab-gcc"

package "git"

bash 'BLIS: Download, configure, and build' do
  # "source /etc/profile" will make sure that files in /etc/profile.d/ are sourced (and the new GCC is used)
  code <<-EOH 
    source /etc/profile
    git clone #{node['blis']['git_repo']}
    cd blis
    ./configure #{node['blis']['architecture']} 2>&1 > .configure.log
    make -j8 2>&1 > .make.log
    cd testsuite
    make 2>&1 > .make.log
  EOH
  cwd node['blis']['root_level_dir']
  not_if { node['blis']['architecture'] == nil }
  not_if { File.exists?("#{node['blis']['root_level_dir']}/blis") }
end

# Perform minimal test: add config file from templates, run test_libblis.x, and log performance results
testDir="#{node['blis']['root_level_dir']}/blis/testsuite"
minimalOut="#{testDir}/.minimal_test.out"

template "#{testDir}/input.general.minimal"  do
  source 'input.general.minimal.erb'
end
template "#{testDir}/input.operations.minimal"  do
  source 'input.operations.minimal.erb'
end
bash 'Minimal BLIS test run' do
  code <<-EOH
    ./test_libblis.x -g input.general.minimal -o input.operations.minimal 2>&1 > #{minimalOut}
    tail -5 #{minimalOut} > #{minimalOut}.perf
  EOH
  cwd "#{testDir}"
  only_if { File.exists?("#{testDir}/test_libblis.x") }
end

ruby_block "Log results of a minimal BLIS test" do
  only_if { ::File.exists?("#{minimalOut}.perf") }
  block do
    File.open("#{minimalOut}.perf").each do |line|
      Chef::Log.info(line)
    end
  end
end
