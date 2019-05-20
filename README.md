# CHEF

  Hi to all. This repository will tell you about chef as such tasty configuration manager for controling your infrastructure. For a little bit more information looking for a link beside     [CHEF](https://docs.chef.io/chef_overview.html "Cheff Overview")
  
Main task you can find at this repo in a file with the same name. 

  Okay let's start. As the chef server we will use hosted chef organizaation. For building nodes infrastructure I will use virtualbox with the superstructure of the vagrant. You can find Vargantfile in this repo which will describe nodes properties. Althought don't forget that every node should bootstrap Cheff Client.
  
  
  
  
  
  First of all need to install chefDK to your machine. [Install ChefDK](https://docs.chef.io/dk_windows.html "Cheff for Windows")
  
  
  we should bootstrap our nodes to hosted chef serve. But you should realize that you can connet to your machine, in my case it looks like:
  
  ```shell
  ssh -i /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key -l vagrant -p 2222 localhost
  ```
  
After this you can bootstrap your node by following:

```shell
knife bootstrap 10.128.236.122 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --node-name awpinst --run-list 'recipe[learn_chef_httpd]'
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
