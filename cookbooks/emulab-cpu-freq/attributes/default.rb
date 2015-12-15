default["cpu_freq_arm"]["kernel_version"] = '3.13.11-ckt29' 

default["cpu_freq_arm"]["kernel_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/kernel-3.13.11-ckt29.tar.gz"
default["cpu_freq_arm"]["kernel_checksum"] = "8c4aff2e41e7daf094d12bf70522246a92a9290dad464eba26ffa6a7d0c562d0"
default["cpu_freq_arm"]["kernel_tar"] = "/tmp/kernel-#{default["cpu_freq_arm"]["kernel_version"]}.tar.gz"

default["cpu_freq_arm"]["modules_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/lib_modules_3.13.11-ckt29.tar.gz"
default["cpu_freq_arm"]["modules_dir"] = "/lib/modules/#{default["cpu_freq_arm"]["kernel_version"]}"
default["cpu_freq_arm"]["modules_tar"] = "#{default["cpu_freq_arm"]["modules_dir"]}/lib_modules_#{default["cpu_freq_arm"]["kernel_version"]}.tar.gz"
