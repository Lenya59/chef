# CHEF

  Hi to all. This repository will tell you about chef as such tasty configuration manager for controlling your infrastructure. For a little bit more information looking for a link beside     [CHEF](https://docs.chef.io/chef_overview.html "Chef Overview")

  Main task you can find at this repo in a file with the same name.

  Okay let's start. As the chef server we will use hosted chef organization. For building nodes infrastructure I will use virtualbox with the superstructure of the vagrant. You can find Vargantfile in this repo which will describe nodes properties. Although don't forget that every node should bootstrap Chef Client(looking for chef_client_boot.sh)


  First of all need to install ChefDK to your machine. [Install ChefDK](https://docs.chef.io/dk_windows.html "Cheff for Windows")

  You should bootstrap  nodes to hosted chef server. But you should realize that you can connect to your machine via ssh, in my case it looks like:
   awpinst node:
```shell
  ssh -i /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key vagrant@10.128.236.122
```
   mysqlinst:  

```shell
ssh -i /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key vagrant@10.128.236.128
```

After this you can bootstrap your node by following:

awpinst:
```shell
knife bootstrap 10.128.236.122 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --node-name awpinst --run-list 'recipe[learn_chef_httpd]'
```
mysqlinst:
```shell
knife bootstrap 10.128.236.128 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key --node-name mysqlinst --run-list 'recipe[learn_chef_httpd]'
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

