name "push_client"
description "Role applied to all nodes running Chef Push jobs"
override_attributes(
  "push_jobs" => {
    "package_url" => "https://web-dl.packagecloud.io/chef/stable/packages/ubuntu/precise/opscode-push-jobs-client_1.1.5-1_amd64.deb",
    "package_checksum" => "d7b40ebb18c7c7dbc32322c9bcd721279e707fd1bee3609a37055838afbf67ea",
    "whitelist" => {
       "power_u" => "cd /tmp ; git clone https://github.com/dmdu/power-client.git ; /bin/bash -x /tmp/power-client/power-client.sh -s utah  -l 6h",
       "power_w" => "cd /tmp ; git clone https://github.com/dmdu/power-client.git ; /bin/bash -x /tmp/power-client/power-client.sh -s wisconsin  -l 6h",
       "power_c" => "cd /tmp ; git clone https://github.com/dmdu/power-client.git ; /bin/bash -x /tmp/power-client/power-client.sh -s clemson  -l 6h"
    }
  }
)
run_list [ "push-jobs" ]
