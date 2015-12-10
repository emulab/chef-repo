emulab-R Cookbook
=================

This cookbook installs R.

Requirements
------------

Depends on emulab-gcc (package for aarch64 requires new GCC).

Attributes
----------

Atributes are set in attributes/default.rb:

Usage
-----

Installing R using instructions from: https://cran.r-project.org/bin/linux/ubuntu/README

default.rb recipe with attributes set in attributes/default.rb should work with no change.

Works on both x86 and aarch64. Tested on Ubuntu 14.04.

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
