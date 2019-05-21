#
# Cookbook Name:: emulab-redis
# Recipe:: default
#

remote_file '/tmp/redis-stable.tar.gz' do
  source "http://download.redis.io/redis-stable.tar.gz"
end

bash 'Install Redis from tarball' do
  code <<-EOH
    cd /tmp/
    tar xvzf redis-stable.tar.gz
    cd redis-stable
    make
    cp src/redis-server /usr/local/bin/
    cp src/redis-cli /usr/local/bin/
  EOH
end

bash 'Run Redis service' do
  code <<-EOH
    redis-server &  
  EOH
end
