emulab-shiny Cookbook
=====================

Install and configure Shiny and all its components (R module, shiny server, etc.).

Default shiny app should be installed in: /srv/shiny-server.

Port 3838 is used for serving the app.

Go to http://<hostname>:3838 to check that the app is displayed and functioning properly.

Requirements
------------

emulab-R cookbook, which installs and configures R.

Attributes
----------

Attributes in attributes/default.rb are self-explanatory.

Usage
-----

Update attributes in attributes/default.rb if necessary and apply the cookbook to appropriate nodes.

Currently, this cookbook only works on x86 nodes (on aarch64 necessary packages are unavailable and need be built from source).

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
