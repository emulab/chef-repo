default["power_arm"]["kernel_version"] = '3.13.11-ckt20' 

# 07/13/15: Latest tarball, which includes boot.scr
default["power_arm"]["kernel_url"] = "https://s3-us-west-2.amazonaws.com/dmdu-cloudlab/kernel-3.13.11-ckt20.tar.gz"
default["power_arm"]["kernel_checksum"] = "8da85617f34e1abe21e51b03a5e5da0815338777cf6dfe3db58c55cde47f4a25"
default["power_arm"]["kernel_tar"] = "/tmp/kernel-#{default["power_arm"]["kernel_version"]}.tar.gz"

default["power_arm"]["i2c_module_url"] = "https://s3-us-west-2.amazonaws.com/dmdu-cloudlab/i2c.tar.gz"
default["power_arm"]["i2c_module_dir"] = "/lib/modules/#{default["power_arm"]["kernel_version"]}"
default["power_arm"]["i2c_module_tar"] = "#{default["power_arm"]["i2c_module_dir"]}/i2c.tar.gz"
