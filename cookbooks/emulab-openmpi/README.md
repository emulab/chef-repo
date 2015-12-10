emulab-openmpi Cookbook
=======================

Install and make available a modern version of OpenMPI.

Requirements
------------

This cookbook depends on emulab-gcc.

Attributes
----------

Attributes are defined and commented in attributes/default.rb.

If default['openmpi']['root_level_dir'] matches default['nfs']['export']['dir'] in the emalab-nfs cookbook, then OpenMPI will be installed and shared across NFS clients - ideal cluster scenario, where this cookbook needs to run only once on the "head" node.

Usage
-----

After this cookbook is applied, OpenMPI will be installed and enabled via: default['openmpi']['profile'].

Tested on Ubuntu 14.04 running on x86 and aarch64. Testing was performed manually, as well as using Test Kitchen (see .kitchen.yml and individual tests in test/).

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
