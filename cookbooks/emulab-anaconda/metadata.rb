name             'emulab-anaconda'
maintainer       'Dmitry Duplyakin'
maintainer_email 'dmitry.duplyakin@colorado.edu'
license          'All rights reserved'
description      'Installs/Configures emulab-redis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.0'

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Issues` link
# issues_url 'https://github.com/<insert_org_here>/emulab-anaconda/issues' if respond_to?(:issues_url)

# If you upload to Supermarket you should set this so your cookbook
# gets a `View Source` link
# source_url 'https://github.com/<insert_org_here>/emulab-anaconda' if respond_to?(:source_url)

depends "anaconda"
