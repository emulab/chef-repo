#
# Cookbook Name:: emulab-redis
# Recipe:: default
#

node.default['redisio']['servers'] = [{'name' => 'master', 'port' => '6379', 'unixsocket' => '/tmp/redis.sock', 'unixsocketperm' => '755'}]

include_recipe "redisio::default"
include_recipe "redisio::enable"
