#
# This role depends on the ruby cookbook 
# available at: https://supermarket.chef.io/cookbooks/ruby
# Make sure it is installed; If is not, try: knife cookbook site install ruby
#
name "ruby"
description "This role is applied to all nodes that need ruby"
override_attributes(
  "languages" => {
    "ruby" => {
      "default_version" => "1.9.3"
    }  
  }
)
run_list [ "ruby" ]
