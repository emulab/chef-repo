emulab-nfs Cookbook
===================
Wrapper around the nfs cookbook (available at Supermarket).

This cookbook allows installing and configuring both the client and the server for NFS.

Requirements
------------
nfs cookbook: https://supermarket.chef.io/cookbooks/nfs

Attributes
----------
This cookbook relies on the attributes listed below.

#### Recipe emulab-nfs::mount

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['nfs']['mount']['dir']</tt></td>
    <td>String</td>
    <td>Where to mount the nfs share. Example: "/exp-share"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['mount']['source']</tt></td>
    <td>String</td>
    <td>NFS Server:NFS Export. Example: "head:/exp-share"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['mount']['options']</tt></td>
    <td>String</td>
    <td>Mount parameters/permissions. Example: "rw"</td>
  </tr>
</table>

#### Recipe emulab-nfs::export

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><tt>['nfs']['packages']</tt></td>
    <td>List of strings</td>
    <td>Example: <tt>[ "portmap", "nfs-common", "nfs-kernel-server" ]</tt></td>
  </tr>
  <tr>
    <td><tt>['nfs']['port']['statd']</tt></td>
    <td>Integer</td>
    <td>Port for statd. Example: 32765</td>
  </tr>
  <tr>
    <td><tt>['nfs']['port']['statd_out']</tt></td>
    <td>Integer</td>
    <td>Port for statd_out. Example: 32766</td>
  </tr>
  <tr>
    <td><tt>['nfs']['port']['mountd']</tt></td>
    <td>Integer</td>
    <td>Port for mountd. Example: 32767</td>
  </tr>
  <tr>
    <td><tt>['nfs']['port']['lockd']</tt></td>
    <td>Integer</td>
    <td>Port for lockd. Example: 32768</td>
  </tr>
  <tr>
    <td><tt>['nfs']['export']['dir']</tt></td>
    <td>String</td>
    <td>Directory being exported. Should match directory in: ['nfs']['mount']['source']. Example: "/exp-share"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['export']['network']</tt></td>
    <td>String</td>
    <td>Network to which the directory is exported (should match the experiment network). Example: "10.0.0.0/8"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['export']['writeable']</tt></td>
    <td>Boolean</td>
    <td>Allow writes. Example: "true"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['export']['sync']</tt></td>
    <td>Boolean</td>
    <td>Allow syncronization. Example: "true"</td>
  </tr>
  <tr>
    <td><tt>['nfs']['export']['options']</tt></td>
    <td>List of strings</td>
    <td>Example: <tt>[ "no_root_squash" ]</tt></td>
  </tr>
</table>

Usage
-----

See how recipes in this cookbook are called in the roles nfs_client.rb and nfs_server.rb (can be found in: https://github.com/emulab/chef-repo/tree/master/roles). Those roles also set appropriately the attributes from above.

Contributing
------------

To contribute, follow the following process:

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Dmitry Duplyakin (dmitry.duplyakin@colorado.edu)
