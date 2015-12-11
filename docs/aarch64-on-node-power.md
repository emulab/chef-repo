Obtaining On-Node Power Measurements on APM X-Genes (64-bit ARMv8, aarch64)
======================

Launch an APM X-Gene node
-----------------

Instantiate arm64-ubuntu14 profile: https://www.cloudlab.us/show-profile.php?uuid=21e55af9-7d82-11e4-afea-001143e453fe

Log in, switch to root, check the kernel:

```
dmdu@node:~$ sudo su -
root@node:~# uname -a
Linux node.dev.utahstud-pg0.utah.cloudlab.us 3.13.0-40-generic #69-Ubuntu SMP Thu Nov 13 19:05:44 UTC 2014 aarch64 aarch64 aarch64 GNU/Linux
```

Install Chef Client (custom package built for aarch64)
-----------------

```
root@node:~# cd /root
root@node:/root# wget https://s3-us-west-2.amazonaws.com/cloudlab-dev/chef_12.5.1%2B20151030195520-1_arm64.deb -O chef_client.deb
--2015-12-14 09:38:44--  https://s3-us-west-2.amazonaws.com/cloudlab-dev/chef_12.5.1%2B20151030195520-1_arm64.deb
Resolving s3-us-west-2.amazonaws.com (s3-us-west-2.amazonaws.com)... 54.231.176.172
Connecting to s3-us-west-2.amazonaws.com (s3-us-west-2.amazonaws.com)|54.231.176.172|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 40893960 (39M) [application/x-debian-package]
Saving to: 'chef_client.deb'

100%[======================================>] 40,893,960  23.5MB/s   in 1.7s

2015-12-14 09:38:46 (23.5 MB/s) - 'chef_client.deb' saved [40893960/40893960]

root@node:/root# dpkg -i chef_client.deb
Selecting previously unselected package chef.
(Reading database ... 73085 files and directories currently installed.)
Preparing to unpack chef_client.deb ...
Unpacking chef (12.5.1+20151030195520-1) ...
Setting up chef (12.5.1+20151030195520-1) ...
Thank you for installing Chef!

root@node:/root# dpkg -l | grep chef
ii  chef                             12.5.1+20151030195520-1          arm64        The full stack of chef
```

Clone Chef repo:
-----------------

```
root@node:/root# git clone https://github.com/emulab/chef-repo.git
Cloning into 'chef-repo'...
remote: Counting objects: 153, done.
remote: Compressing objects: 100% (90/90), done.
remote: Total 153 (delta 26), reused 153 (delta 26), pack-reused 0
Receiving objects: 100% (153/153), 36.36 KiB | 0 bytes/s, done.
Resolving deltas: 100% (26/26), done.
Checking connectivity... done.

root@node:/root# cd chef-repo/cookbooks/emulab-power
root@node:/root/chef-repo/cookbooks/emulab-power# ls
CHANGELOG.md  README.md  attributes  metadata.rb  recipes  templates
```

If necessart, inspect recipes/aarch64.rb to see what is going to happen when we run emulab-power cookbook. This recipe will only run on aarch64 nodes.


Run Chef Zero (serverless mode)
-----------------

```
root@node:/root/chef-repo/cookbooks/emulab-power# chef-client -z -o emulab-power
Synchronizing Cookbooks:
  - emulab-power (0.1.0)
Compiling Cookbooks...
Converging 8 resources
Recipe: emulab-power::aarch64
...
...
...
```

After some time, the node should reboot.

Reconnect to the node after a few minutes and check the kernel
-----------------

```
dmdu@node:~$ sudo su -
root@node:~# uname -a
Linux node.dev.utahstud-pg0.utah.cloudlab.us 3.13.11-ckt20 #1 SMP Thu Jun 25 09:41:42 MDT 2015 aarch64 aarch64 aarch64 GNU/Linux
```

Check that SLIMPRO is enabled: 

```
root@node:~# dmesg | grep xgene-slimpro-i2c
[   10.132469] xgene-slimpro-i2c xgene-slimpro-i2c: APM X-Gene SLIMpro I2C Adapter registered
```

Run emulab-power with Chef Zero one more time 
-----------------

This time, this cookbook will do other things: install necessary packages, load i2c_dev modele, get a test script, etc.

```
root@node:~# cd /root/chef-repo/cookbooks/emulab-power
root@node:/root/chef-repo/cookbooks/emulab-power# chef-client -z -o emulab-power
resolving cookbooks for run list: ["emulab-power"]
Synchronizing Cookbooks:
  - emulab-power (0.1.0)
Compiling Cookbooks...
Converging 8 resources
Recipe: emulab-power::aarch64
  * log[Kernel has been patched already - version 3.13.11-ckt20] action write
...
...
...
```

Run the test script
-----------------

If all goes well, run the installed test script, and you should see the following output:

```
/bin/bash /tmp/on-node-power.sh
rcvd: 52 00 32
Count: 1
rcvd: 52 00 32
Count: 2
rcvd: 52 00 32
Count: 3
rcvd: 52 00 32
Count: 4
rcvd: 52 00 32
Count: 5
...
```

This script is only meant to show that the necessary components are in place and things are working. In order to actaully obtain power measurements, do the following:

```
root@node:~# cd /tmp
root@node:/tmp# git clone https://github.com/emulab/arm-power-tools.git
Cloning into 'arm-power-tools'...
remote: Counting objects: 46, done.
remote: Total 46 (delta 0), reused 0 (delta 0), pack-reused 45
Unpacking objects: 100% (46/46), done.
Checking connectivity... done.
root@node:/tmp# cd arm-power-tools/
root@node:/tmp/arm-power-tools# /bin/bash driver.sh 

```

The last line starts the script that will log voltage (VIN) and current (IOT) into: /var/log/power/<hostname>

Stop the scipt and inspect the data that it produced. For example:

```
root@node:/tmp/arm-power-tools# cat /var/log/power/ms0327.utah.cloudlab.us.log 
1450114349.98,2015-12-14 17:32:29.975876,ms0327.utah.cloudlab.us,IOUT,rcvd: 52 00 EE 08,2.95184
1450114351.1,2015-12-14 17:32:31.099831,ms0327.utah.cloudlab.us,VIN,rcvd: 52 00 32 09,12.259632
1450114352.2,2015-12-14 17:32:32.203094,ms0327.utah.cloudlab.us,IOUT,rcvd: 52 00 E2 08,2.80316
1450114353.35,2015-12-14 17:32:33.350884,ms0327.utah.cloudlab.us,VIN,rcvd: 52 00 33 09,12.26484
1450114354.5,2015-12-14 17:32:34.499116,ms0327.utah.cloudlab.us,IOUT,rcvd: 52 00 E0 08,2.77838
1450114355.65,2015-12-14 17:32:35.648908,ms0327.utah.cloudlab.us,VIN,rcvd: 52 00 32 09,12.259632
1450114356.75,2015-12-14 17:32:36.752982,ms0327.utah.cloudlab.us,IOUT,rcvd: 52 00 DE 08,2.7536
1450114357.9,2015-12-14 17:32:37.898895,ms0327.utah.cloudlab.us,VIN,rcvd: 52 00 32 09,12.259632
1450114359.05,2015-12-14 17:32:39.049075,ms0327.utah.cloudlab.us,IOUT,rcvd: 52 00 E6 08,2.85272
1450114360.15,2015-12-14 17:32:40.152895,ms0327.utah.cloudlab.us,VIN,rcvd: 52 00 32 09,12.259632
```

Questions?
-------------

If necessary, contact Dmitry Duplyakin <dmitry.duplyakin@colorado.edu>
