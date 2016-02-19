default['hpgmg']['root_level_dir'] = "/exp-share"
default['hpgmg']['repo'] = "https://bitbucket.org/hpgmg/hpgmg"
default['hpgmg']['HPGMG_CFLAGS-x86'] = "-march=native -O3 -ffast-math -ftree-vectorize -funsafe-math-optimizations"
default['hpgmg']['HPGMG_CFLAGS-aarch64'] = "-march=armv8-a+fp+simd -mcpu=cortex-a57.cortex-a53 -mtune=cortex-a57.cortex-a53 -O3 -ffast-math -ftree-vectorize -funsafe-math-optimizations"
