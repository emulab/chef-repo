#
# This role depends on the nginx cookbook 
# available at: https://supermarket.chef.io/cookbooks/nginx
# Make sure it is installed; If is not, try: knife cookbook site install nginx
#
name "nginx"
description "This role is applied to all nodes, on which nginx should be automatically installed and configured"
override_attributes(
  "nginx" => {
    "port" => "8080",
    "dir" => "/etc/nginx",
    "default_root" => "/var/www/nginx-default",
    "log_dir" => "/var/log/nginx"
  }
)
run_list [ "nginx" ]
