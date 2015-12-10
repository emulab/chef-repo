Description
-----------

Installs and configures SLURM.

default.rb recipe will install SLURM essentials.

accounting.rb will install and configure necessary components for SLURM accounting - only runs on the head node.

example.rb will create an example, which can help verify that SLURM is functioning properly - only runs on the head node.

A node is determined to be the head node if its short name matches the ["slurm"]["control_machine"] attribute (see below).

Requirements
------------

Requires apt and mysql (both are cookbooks from Supermarket), as well as emulab-openmpi (needed to enable mpirun and mpicc in order to run parallel jobs).

To install Supermarket cookbooks, try: knife cookbook site install <name of the cookbook>.

example.rb recipe will call emulab-openmpi cookbook (that one will likely call emulab-gcc cookbook to get the latest GCC).

Attributes
==========

attributes/default.rb contains many attributes (which can be updated with caution).

Usage
-----

Tested on Ubuntu 14.04 using both manual tests and Kitchen tests (see test/integration/default/bats/slurm_installed.bats; those tests primarily test the essentials).

Three attributes should be set in a role or an environment file: control_machine, control_addr, node_list.

Here is an example (from slurm.rb role):

override_attributes(
  "slurm" => {
    "control_machine" => "x-node-0",
    "control_addr" => "10.10.1.1",
    "node_list" => "x-node-[0-1]"
    }  
)

In the same role, we can set the run list (in order to call all three recipes in this cookbook): 

run_list [ "emulab-slurm::default", "emulab-slurm::accounting", "emulab-slurm::example" ]

node_list attribute should include only nodes that have resolvable names (present in /etc/hosts). Otherwise, SLURM control daemon won't launch properly.

A role with these attributes and such run list can be applied to all nodes in a SLURM cluster. A node, which has the name that matches the ["slurm"]["control_machine"] attribute, will become the head node and also install accounting components (mysql, slurmdbd, etc.). The rest of the nodes will become worker nodes and will execute jobs from the work queue (those nodes will essentially skip the code in accounting.rb and example.rb). 

If example.rb recipe is selected to run, it will print commands for testing job submission and checking job history. Follow those commands to make sure that everything is functioning properly.

Useful SLURM commands:

- Show what is running on the node: scontrol show daemons
- Node info (slightly more detailed): sinfo -Nel
- Graphical SLURM interface (update every second): smap -i 1

Other SLURM commands:

- Submit a job:                    sbatch myjob.sh
- Delete a job:                    scancel 123
- Show job status:                 squeue
- Show expected job start time:    squeue --start
- Show queue info:                 sinfo
- Show job details:                scontrol show job 123
- Show queue details:              scontrol show partition
- Show node details:               scontrol show node n0000
- Show QoS details:                sacctmgr show qos
- Show history of all jobs:      	sacct
- Show detailed history:		sacct --long
- Show history (selected fields):	sacct --format=jobid,jobname,account,partition,ntasks,alloccpus,elapsed,state,exitcode

Contributing
------------

To contribute, follow these steps:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

Authors: Dmitry Duplyakin (dmitry.duplyakin@colorado.edu)
