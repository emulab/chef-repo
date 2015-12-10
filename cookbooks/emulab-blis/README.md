emulab-blis Cookbook
====================

Download and build BLIS (latest stable version from GitHub).

Requirements
------------

This cookbook depends on emulab-gcc (BLIS can be built with a old version of GCC, but the performance will not be optimal).

Attributes
----------
Attributes are defined and commented in attributes/default.rb.

If default['blis']['root_level_dir'] matches default['nfs']['export']['dir'] in the emalab-nfs cookbook, then BLIS will be installed and shared across NFS clients - ideal cluster scenario, where this cookbook needs to run only once on the "head" node.

Usage
-----

After this cookbook is applied, BLIS will be downloaded and built inside: default['blis']['root_level_dir']/blis.

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

