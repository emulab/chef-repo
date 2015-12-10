emulab-powervis Cookbook
========================

Install and configure powervis - the dashboard for interactive analysis and visualization of experiment power data on CloudLab. 

powervis is developed by Dmitry Duplyakin (dmitry.duplyakin@colorado.edu) and hosted at: https://github.com/emulab/shiny-server

Requirements
------------

Requires emulab-shiny.

Attributes
----------

default['powervis']['repo'] points to the repo where powervis is hosted.

Usage
-----

default recipe should work as is (with the repo specified in attributes/default.rb)

Currently, this cookbook only works on x86 nodes (on aarch64 necessary packages are unavailable and need to be built from source).

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
