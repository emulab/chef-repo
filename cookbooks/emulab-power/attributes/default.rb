default["power_arm"]["kernel_version"] = '3.13.11-ckt29' 

# 07/13/15: Latest tarball, which includes boot.scr
default["power_arm"]["kernel_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/kernel-3.13.11-ckt29.tar.gz"
default["power_arm"]["kernel_checksum"] = "8c4aff2e41e7daf094d12bf70522246a92a9290dad464eba26ffa6a7d0c562d0"
default["power_arm"]["kernel_tar"] = "/tmp/kernel-#{default["power_arm"]["kernel_version"]}.tar.gz"

default["power_arm"]["i2c_module_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/lib_modules_3.13.11-ckt29.tar.gz"
default["power_arm"]["i2c_module_dir"] = "/lib/modules/#{default["power_arm"]["kernel_version"]}"
default["power_arm"]["i2c_module_tar"] = "#{default["power_arm"]["i2c_module_dir"]}/lib_modules_#{default["power_arm"]["kernel_version"]}.tar.gz"
