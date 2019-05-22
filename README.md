# CHEF

  Hi to all. This repository will tell you about chef as such tasty configuration manager for controlling your infrastructure. For a little bit more information looking for a link beside     [CHEF](https://docs.chef.io/chef_overview.html "Chef Overview")

  Main task you can find at this repo in a file with the same name.

  Okay let's start. As the chef server we will use hosted chef organization. For building nodes infrastructure I will use virtualbox with the superstructure of the vagrant. You can find Vargantfile in this repo which will describe nodes properties. Although don't forget that every node should bootstrap Chef Client(looking for chef_client_boot.sh)


  First of all need to install ChefDK to your machine. [Install ChefDK](https://docs.chef.io/dk_windows.html "Cheff for Windows")

  You should bootstrap  nodes to hosted chef server. But you should realize that you can connect to your machine via ssh, in my case it looks like:
   awpinst node:
```shell
$ ssh -i /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key vagrant@10.128.236.122
```
   mysqlinst:  

```shell
$ ssh -i /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key vagrant@10.128.236.128
```

After this you can bootstrap your node by following:

awpinst:
```shell
$ knife bootstrap 10.128.236.122 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --node-name awpinst --run-list 'recipe[learn_chef_httpd]'
```
mysqlinst:
```shell
$ knife bootstrap 10.128.236.128 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key --node-name mysqlinst --run-list 'recipe[learn_chef_httpd]'
```


You get smthng like this:

```shell
m_package[httpd] action install
10.128.236.122     - install version 0:2.4.6-89.el7.centos.x86_64 of package httpd
10.128.236.122   * service[httpd] action enable
10.128.236.122     - enable service service[httpd]
10.128.236.122   * service[httpd] action start
10.128.236.122     - start service service[httpd]
10.128.236.122   * template[/var/www/html/index.html] action create
10.128.236.122     - create new file /var/www/html/index.html
10.128.236.122     - update content in file /var/www/html/index.html from none to ef4ffd
10.128.236.122     --- /var/www/html/index.html 2019-05-20 16:43:19.354814573 +0000
10.128.236.122     +++ /var/www/html/.chef-index20190520-21977-1roy13z.html
  2019-05-20 16:43:19.354814573 +0000
10.128.236.122     @@ -1 +1,6 @@
10.128.236.122     +<html>
10.128.236.122     +  <body>
10.128.236.122     +    <h1>hello world</h1>
10.128.236.122     +  </body>
10.128.236.122     +</html>
10.128.236.122     - restore selinux security context
10.128.236.122
10.128.236.122 Running handlers:
10.128.236.122 Running handlers complete
10.128.236.122 Chef Client finished, 4/4 resources updated in 12 seconds
```
and the same output for second node :-)

Go on)

When you add your nodes, you can go to your mange chef acount (in my case it is https://manage.chef.io/organizations/okuli/nodes), and manage you nodes right here. It looks something like this:

![mange_chef_nodes](https://user-images.githubusercontent.com/30426958/58090389-cf6d3c00-7bcf-11e9-8e64-53edc302ded0.png)

Next step is to assign roles to our nodes. [A little bit more info about roles you can find here](https://docs.chef.io/roles.html "roles")

Small lyrical digression, Chef uses Ruby as its reference language to define the patterns that are found in resources, recipes, and cookbooks. Therefore here is tasty links to learn more about Ruby:

[Ruby Documentation](https://www.ruby-lang.org/en/documentation/)

[Ruby Standard Library Documentation](https://ruby-doc.org/stdlib-2.6.3/)


ROLES!!!


Let's create cookbook for apache. From  workstation, move to our cookbooks directory

Create the cookbook:

```shell
$ chef generate cookbook apache
Generating cookbook apache
- Ensuring correct cookbook file content
- Ensuring delivery configuration
- Ensuring correct delivery build cookbook content

Your cookbook is ready. Type `cd apache` to enter it.

There are several commands you can run to get started locally developing and testing your cookbook.
Type `delivery local --help` to see a full list.

Why not start by writing a test? Tests for the default recipe are stored at:

test/integration/default/default_test.rb

If you'd prefer to dive right in, the default recipe can be found at:

recipes/default.rb
```
When you go to your cookbook directory(apache in our case) adn type ll, you can see smthng like this:\

```shell
-rw-r--r-- 1 okuli 1049089   77 May 22 16:55 Berksfile
-rw-r--r-- 1 okuli 1049089  161 May 22 16:55 CHANGELOG.md
-rw-r--r-- 1 okuli 1049089 1090 May 22 16:55 chefignore
-rw-r--r-- 1 okuli 1049089   73 May 22 16:55 LICENSE
-rw-r--r-- 1 okuli 1049089  742 May 22 16:55 metadata.rb
-rw-r--r-- 1 okuli 1049089   58 May 22 16:55 README.md
drwxr-xr-x 1 okuli 1049089    0 May 22 17:01 recipes/
drwxr-xr-x 1 okuli 1049089    0 May 22 16:55 spec/
drwxr-xr-x 1 okuli 1049089    0 May 22 16:55 test/
```
Recipe:
A recipe consists of a series of resources which defines the state of a particular service or an application, for example, one resource could say “the NTP service should be running”, another may say “the telnet service should be stopped”

Go to the recipes directory. There you can see a file called “default.rb“. We are going to use this file to add resources for that are required for getting the Apache server running.

```shell
cat default.rb
#
# Cookbook:: apache
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
```
Install Apache:

To begin, let’s add a resource for installing apache package.

```ruby
package 'httpd' do
  action :install
end
```

package – Defines package resource

httpd –  Name of the package you want to install, should be a legitimate package name.

action :install –  This specifies the action for the resource “package“, in our case, installation of httpd.

Where,

service – Defines service resource.

httpd –  The name of the service, should be a legitimate service name.

action [ :enable, :start ] – Specify actions that you want to perform. In our case, this resource will start “httpd” and enable it on start up.

Index File:

Our next resource is for placing the index.html file on the document root of Apache server. All you need to specify the location where want the file and from where to get the file.

Where,

cookbook_file – Resource to transfer files from a sub-directory of httpd/files to a mentioned path located on a chef node.

source – Specify the name of the source file. Files are normally found in COOK_BOOKS/files.

mode – Sets the permissions for the file.

Creating the Index File:

Since we have defined a “cookbook_file” resource, we need to create a source file “index.html” inside files subdirectory of your cookbook.
```shell
cd ~/chef-repo/cookbooks
```
Create a subdirectory “files” under your cookbook:
```shell
mkdir apache/files
```

Add a simple text into the index.html.

```shell
echo "Installed and Setup Using Chef" > httpd/files/index.html
```










Once your cookbook is complete, you can upload them on to your Chef server.

```shell
knife cookbook upload httpd
Uploading apache         [0.1.0]
Uploaded 1 cookbook.
```
Check whether you can list the cookbook that you just have been uploaded.

```shell
knife cookbook list

apache   0.1.0
````

You can add a cookbook to the run_list of a particular node using the following command.

```shell
knife node run_list add awpinst apache

awpinst:
  run_list:
    role[web]
    recipe[apache::apache]
    recipe[apache]
```







































The Chef Supermarket has an OpsCode-maintained [MySQL cookbook](https://supermarket.chef.io/cookbooks/mysql)

From the workstation, download and install the cookbook:

```shell
knife cookbook site install mysql
```
This will also install any and all dependencies required to use the cookbook. These dependencies include the smf and yum-mysql-community cookbooks, which in turn depend on the rbac and yum cookbooks.


```shell
knife cookbook site install mysql
WARN: knife cookbook site install has been deprecated in favor of knife supermarket install. In Chef 16 (April 2020) this will result in an error!
Installing mysql to C:/Users/okuli/chef/cookbooks
Checking out the master branch.
Creating pristine copy branch chef-vendor-mysql
WARN: knife cookbook site download has been deprecated in favor of knife supermarket download. In Chef 16 (April 2020) this will result in an error!
Downloading mysql from Supermarket at version 8.5.1 to C:/Users/okuli/chef/cookbooks/mysql.tar.gz
Cookbook saved: C:/Users/okuli/chef/cookbooks/mysql.tar.gz
Removing pre-existing version.
Uncompressing mysql version 8.5.1.
Removing downloaded tarball
1 files updated, committing changes
Creating tag cookbook-site-imported-mysql-8.5.1
Checking out the master branch.
Updating 33c26af..efb0772
Fast-forward
 cookbooks/mysql/.foodcritic                        |   1 +
 cookbooks/mysql/CHANGELOG.md                       | 692 +++++++++++++++++++++
 cookbooks/mysql/CONTRIBUTING.md                    |   2 +
 cookbooks/mysql/README.md                          | 424 +++++++++++++
 cookbooks/mysql/libraries/helpers.rb               | 291 +++++++++
 cookbooks/mysql/libraries/matchers.rb              |  71 +++
 cookbooks/mysql/libraries/mysql_base.rb            |  30 +
 .../libraries/mysql_client_installation_package.rb |  31 +
 cookbooks/mysql/libraries/mysql_config.rb          |  56 ++
 .../libraries/mysql_server_installation_package.rb |  42 ++
 cookbooks/mysql/libraries/mysql_service.rb         | 105 ++++
 cookbooks/mysql/libraries/mysql_service_base.rb    | 203 ++++++
 .../libraries/mysql_service_manager_systemd.rb     | 142 +++++
 .../libraries/mysql_service_manager_sysvinit.rb    |  79 +++
 .../libraries/mysql_service_manager_upstart.rb     | 103 +++
 cookbooks/mysql/metadata.json                      |   1 +
 .../default/apparmor/usr.sbin.mysqld-instance.erb  |  14 +
 .../default/apparmor/usr.sbin.mysqld-local.erb     |   1 +
 .../templates/default/apparmor/usr.sbin.mysqld.erb |  47 ++
 cookbooks/mysql/templates/default/my.cnf.erb       |  57 ++
 .../templates/default/smf/svc.method.mysqld.erb    |  28 +
 .../default/systemd/mysqld-wait-ready.erb          |  30 +
 .../templates/default/systemd/mysqld.service.erb   |  16 +
 .../mysql/templates/default/sysvinit/mysqld.erb    | 279 +++++++++
 .../mysql/templates/default/tmpfiles.d.conf.erb    |   1 +
 .../default/upstart/mysqld-wait-ready.erb          |  22 +
 .../mysql/templates/default/upstart/mysqld.erb     |  26 +
 27 files changed, 2794 insertions(+)
 create mode 100644 cookbooks/mysql/.foodcritic
 create mode 100644 cookbooks/mysql/CHANGELOG.md
 create mode 100644 cookbooks/mysql/CONTRIBUTING.md
 create mode 100644 cookbooks/mysql/README.md
 create mode 100644 cookbooks/mysql/libraries/helpers.rb
 create mode 100644 cookbooks/mysql/libraries/matchers.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_base.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_client_installation_package.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_config.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_server_installation_package.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_service.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_service_base.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_service_manager_systemd.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_service_manager_sysvinit.rb
 create mode 100644 cookbooks/mysql/libraries/mysql_service_manager_upstart.rb
 create mode 100644 cookbooks/mysql/metadata.json
 create mode 100644 cookbooks/mysql/templates/default/apparmor/usr.sbin.mysqld-instance.erb
 create mode 100644 cookbooks/mysql/templates/default/apparmor/usr.sbin.mysqld-local.erb
 create mode 100644 cookbooks/mysql/templates/default/apparmor/usr.sbin.mysqld.erb
 create mode 100644 cookbooks/mysql/templates/default/my.cnf.erb
 create mode 100644 cookbooks/mysql/templates/default/smf/svc.method.mysqld.erb
 create mode 100644 cookbooks/mysql/templates/default/systemd/mysqld-wait-ready.erb
 create mode 100644 cookbooks/mysql/templates/default/systemd/mysqld.service.erb
 create mode 100644 cookbooks/mysql/templates/default/sysvinit/mysqld.erb
 create mode 100644 cookbooks/mysql/templates/default/tmpfiles.d.conf.erb
 create mode 100644 cookbooks/mysql/templates/default/upstart/mysqld-wait-ready.erb
 create mode 100644 cookbooks/mysql/templates/default/upstart/mysqld.erb
Cookbook mysql version 8.5.1 successfully installed
```

