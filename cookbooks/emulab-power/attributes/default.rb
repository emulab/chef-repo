# x86_64-specific attributes
default["power_x86"]["logger_dir"] = '/root/power_logger'
default["power_x86"]["logs_dir"] = '/var/log/power_logs'
default["power_x86"]["sample_interval_sec"] = 1
# Number of samples to take or 'INF'
default["power_x86"]["sample_limit"] = 'INF'
default["power_x86"]["logger_pid_file"] = '/var/run/power_logger.pid'

# aarch64-specific attributes
default["power_arm"]["kernel_version"] = '3.13.11-ckt29' 
default["power_arm"]["kernel_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/kernel-3.13.11-ckt29.tar.gz"
default["power_arm"]["kernel_checksum"] = "8c4aff2e41e7daf094d12bf70522246a92a9290dad464eba26ffa6a7d0c562d0"
default["power_arm"]["kernel_tar"] = "/tmp/kernel-#{default["power_arm"]["kernel_version"]}.tar.gz"
default["power_arm"]["i2c_module_url"] = "https://s3-us-west-2.amazonaws.com/kernel-and-modules/lib_modules_3.13.11-ckt29.tar.gz"
default["power_arm"]["i2c_module_dir"] = "/lib/modules/#{default["power_arm"]["kernel_version"]}"
default["power_arm"]["i2c_module_tar"] = "#{default["power_arm"]["i2c_module_dir"]}/lib_modules_#{default["power_arm"]["kernel_version"]}.tar.gz"
