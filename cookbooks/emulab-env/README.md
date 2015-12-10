emulab-env Cookbook
===================

Common configuration for emulab experiments: packages, aliases, email configuration, etc.

#### emulab-env::default

Calls all other recipes in this cookbook.

#### emulab-env::packages

Installs common packages: git, wget, vim, etc.

#### emulab-env::templates

Copies templates/\* into specified locations. 

#### emulab-env::email

Enables sending emails to the owner of an experiment.

After this recipe is applied, /etc/profile.d/emulab-email.sh should contain the SWAPPER_EMAIL variable set appropriately. Then, you (or your code) should be able 
to send an email via: 

<tt>echo "BODY" | mail -s "SUBJECT" ${SWAPPER_EMAIL} & </tt>

Requirements
------------

Stand-alone cookbook.

Attributes
----------

No attributes (some parameters are hard-coded in recipes and can become attributes in the future).

Usage
-----

Useable as is. Apply the default or specific recipes to appropriate nodes. 

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
