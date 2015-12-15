Enabling CPU frequency control on APM X-Genes (64-bit ARMv8, aarch64)
======================

This procedure is similar to the one for obtaining on-node power measurements on ARM described at: https://github.com/emulab/chef-repo/blob/master/docs/aarch64-on-node-power.md

Both procedures use the same kernel with custom patches and flags. Also, the same kernel modules are used.

Prerequisites
-----------------

In the intructions below, we use a node with Chef Server and a single ARM node.
To make things clear, we will prefix commands below with "CHEF" if those commands need to be executed on the former, and use the "ARM" prefix for the commands on the latter.

Instructions for launching and operating Chef Server will be written in a separate document.

Instantiate arm64-ubuntu14 profile: https://www.cloudlab.us/show-profile.php?uuid=21e55af9-7d82-11e4-afea-001143e453fe

Log in, switch to root, check the kernel:

```
ARM: dmdu@node:~$ sudo su -
ARM: root@node:~# uname -a
Linux x-node-0.arm-dev.utahstud-pg0.utah.cloudlab.us 3.13.0-40-generic #69-Ubuntu SMP Thu Nov 13 19:05:44 UTC 2014 aarch64 aarch64 aarch64 GNU/Linux
```

Install Chef Client (custom package built for aarch64)
-----------------

```
ARM: root@node:~# cd /root
ARM: root@node:/root# wget https://s3-us-west-2.amazonaws.com/cloudlab-dev/chef_12.5.1%2B20151030195520-1_arm64.deb -O chef_client.deb
--2015-12-14 09:38:44--  https://s3-us-west-2.amazonaws.com/cloudlab-dev/chef_12.5.1%2B20151030195520-1_arm64.deb
Resolving s3-us-west-2.amazonaws.com (s3-us-west-2.amazonaws.com)... 54.231.176.172
Connecting to s3-us-west-2.amazonaws.com (s3-us-west-2.amazonaws.com)|54.231.176.172|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 40893960 (39M) [application/x-debian-package]
Saving to: 'chef_client.deb'

100%[======================================>] 40,893,960  23.5MB/s   in 1.7s

2015-12-14 09:38:46 (23.5 MB/s) - 'chef_client.deb' saved [40893960/40893960]

ARM: root@node:/root# dpkg -i chef_client.deb
Selecting previously unselected package chef.
(Reading database ... 73085 files and directories currently installed.)
Preparing to unpack chef_client.deb ...
Unpacking chef (12.5.1+20151030195520-1) ...
Setting up chef (12.5.1+20151030195520-1) ...
Thank you for installing Chef!

ARM: root@node:/root# dpkg -l | grep chef
ii  chef                             12.5.1+20151030195520-1          arm64        The full stack of chef
```

For the following instructions to work, you need to make sure that CHEF node can ssh into ARM as root (copy ~/.ssh/id_rsa.pub from CHEF and paste into ~/.ssh/authorized_keys2 on ARM, if necessary).

Bootstrap Chef on the ARM node from Chef server:
-----------------

It is recommended to add FQDN of the ARM node to /etc/hosts on the CHEF node. For instance, add a line:
```
msXXX.utah.cloudlab.us a1
```

msXXX.utah.cloudlab.us is the FQDN on the ARM node. a1 is a short name we are going to use for the ARM node when managing it via Chef.

Bootstrap:

```
CHEF: root@node:~# knife bootstrap msXXX.utah.cloudlab.us -N a1 -E utah
```

"-E utah" makes ARM node be a part of the Utah environment (see specific attributes in environments/utah.rb)

Assign cookbook
-----------------

```
CHEF: root@node:~# knife node run_list add a1 "emulab-cpu-freq"
```

You also may want to run: "knife cookbook list" and make sure that "emulab-cpu-freq" shows up in that list.
If it does not, try: "knife cookbook upload emulab-cpu-freq"

Converge ARM node (trigger the updates and run the cookbook)
-----------------

```
CHEF: root@head:~# knife ssh "name:a1" chef-client
ms0223.utah.cloudlab.us Starting Chef Client, version 12.5.1
ms0223.utah.cloudlab.us resolving cookbooks for run list: ["emulab-cpu-freq"]
ms0223.utah.cloudlab.us Synchronizing Cookbooks:
ms0223.utah.cloudlab.us   - emulab-cpu-freq (1.0.0)
ms0223.utah.cloudlab.us Compiling Cookbooks...
ms0223.utah.cloudlab.us Converging 8 resources
ms0223.utah.cloudlab.us Recipe: emulab-cpu-freq::aarch64
...
...
...
The system is going down for reboot NOW!
ms0223.utah.cloudlab.us 
ms0223.utah.cloudlab.us     - execute reboot
ms0223.utah.cloudlab.us 
ms0223.utah.cloudlab.us Running handlers:
ms0223.utah.cloudlab.us Running handlers complete
ms0223.utah.cloudlab.us Chef Client finished, 5/8 resources updated in 08 seconds
```

ARM node should be rebooting now.

Check things in a few minutes, after the node reboots
-----------------

```
CHEF: root@head:~# knife ssh "name:a1" "uname -a"
ms0223.utah.cloudlab.us Linux x-node-0.arm-dev.utahstud-pg0.utah.cloudlab.us 3.13.11-ckt29 #1 SMP Mon Dec 14 14:36:51 MST 2015 aarch64 aarch64 aarch64 GNU/Linux

CHEF: root@head:~# knife ssh "name:a1" "lsmod | grep xgene_cpufreq"
ms0223.utah.cloudlab.us xgene_cpufreq           3997  0 
```

Run the cookbook again
-----------------

This time, it will do other things: load the modules (if necessary), install test scripts, etc.

```
CHEF: root@head:~# knife ssh "name:a1" chef-client
```

Experiment with setting the frequency
-----------------

A script for changing the frequency on all cores should now be installed on the ARM node at: /usr/local/bin/set_freq.sh

```
CHEF: root@head:~# knife ssh "name:a1" "set_freq.sh 600000"

CHEF: root@head:~# knife ssh "name:a1" "cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
ms0223.utah.cloudlab.us 600000

CHEF: root@head:~# knife ssh "name:a1" "cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state"
ms0223.utah.cloudlab.us 600000 5657
ms0223.utah.cloudlab.us 800000 0
ms0223.utah.cloudlab.us 1200000 27105
ms0223.utah.cloudlab.us 2400000 69996

CHEF: root@head:/chef-repo/cookbooks# knife ssh "name:a1" "set_freq.sh 800000"

CHEF: root@head:/chef-repo/cookbooks# knife ssh "name:a1" "cat /sys/devices/system/cpu/cpu0/cpufreq/stats/time_in_state"
ms0223.utah.cloudlab.us 600000 27840
ms0223.utah.cloudlab.us 800000 1885
ms0223.utah.cloudlab.us 1200000 27105
ms0223.utah.cloudlab.us 2400000 69996
```

Chef Zero
------------

If you want to avoid dealing with Chef server, you can use Chef Zero instead. Similar to the instuctions for obtaining on-node power (see: https://github.com/emulab/chef-repo/blob/master/docs/aarch64-on-node-power.md), try the following:
- Install Chef Client on the ARM node, exactly as described above
- As root: chef-client -z -o emulab-cpu-freq
- Wait until the node reboots
- Again, as root: chef-client -z -o emulab-cpu-freq
- Set frequency, as described above

Questions?
-------------

If necessary, contact Dmitry Duplyakin <dmitry.duplyakin@colorado.edu>
