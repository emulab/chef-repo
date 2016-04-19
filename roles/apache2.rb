#
# This role depends on the apache2 cookbook
# available at: https://supermarket.chef.io/cookbooks/apache2
# Make sure it is installed. If it is not installed, try: 
# knife cookbook site install apache2
#
name "apache2"
description "This role is applied to the nodes on which apache2 should be installed"
override_attributes(
  "apache" => {
    "listen" => ["8080"],
    "default_site_port" => "8080",
    "default_site_enabled" => true,
  }
)
run_list [ "apache2", "apache2::mod_autoindex" ]
