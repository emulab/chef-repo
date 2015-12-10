#
# Cookbook Name:: emulab-R
# Recipe:: x86
#

bash 'Add CRAN repo' do
  code <<-EOH
    apt-get update
    apt-get install -y software-properties-common
    version=$(lsb_release -c -s) 
    echo "deb http://ftp.ussg.iu.edu/CRAN/bin/linux/ubuntu $version/" > /etc/apt/sources.list.d/r-base.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
    apt-get update
  EOH
end

apt_package 'r-base' do
  action :upgrade
end
