#
# This role depends on the emulab-apachebench cookbook
#
name "apachebench"
description "This role is applied to the nodes on which apachebench should be installed and run"
override_attributes(
  "apachebench" => {
    "target_host" => nil,
    "ports" => [80, 443]
  }
)
run_list [ "emulab-apachebench" ]
