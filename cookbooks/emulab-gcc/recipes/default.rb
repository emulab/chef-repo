#
# Cookbook Name:: emulab-gcc
# Recipe:: default
#

include_recipe 'apt'

package 'software-properties-common'

apt_repository "toolchain" do
  uri "ppa:ubuntu-toolchain-r/test"
  distribution node['lsb']['codename']
  components ["main"]
end

package 'gcc-5'
package 'g++-5'
package 'gfortran-5'

bash 'Update symlinks to make new gcc used by default' do
  code <<-EOH
    update-alternatives --install /usr/bin/gcc 		gcc 		/usr/bin/gcc-5 		20 
    update-alternatives --install /usr/bin/g++ 		g++ 		/usr/bin/g++-5 		20 
    update-alternatives --install /usr/bin/gfortran 	gfortran 	/usr/bin/gfortran-5 	20
    update-alternatives --install /usr/bin/gcc-ar 	gcc-ar 		/usr/bin/gcc-ar-5 	20 
    update-alternatives --install /usr/bin/gcc-nm 	gcc-nm 		/usr/bin/gcc-nm-5 	20 
    update-alternatives --install /usr/bin/gcc-ranlib 	gcc-ranlib 	/usr/bin/gcc-ranlib-5 	20
    update-alternatives --install /usr/bin/gcov 	gcov 		/usr/bin/gcov-5		20 
  EOH
end
