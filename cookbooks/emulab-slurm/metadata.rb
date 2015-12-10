name             'emulab-slurm'
maintainer       "Dmitry Duplyakin"
maintainer_email "dmitry.duplyakin@colorado.edu"
license          "All rights reserved"
description      "Installs/Configures emulab-slurm"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "1.0.0"

depends "apt"

# Required for accounting
depends "mysql"

# MPI is installed only if example.rb recipe is called
depends "emulab-openmpi"
