emulab-gcc Cookbook
===================

Install the latest version of GCC.

Requirements
------------

Depends on the apt cookbook from Supermarket.

Usage
-----

Assign this cookbook to a node (as is or as part of a role) and converge the node. After that, the latest gcc, g++, and gfortran should be enabled.

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
