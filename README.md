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
$ knife bootstrap 10.128.236.122 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --node-name awpinst 
mysqlinst:
```shell
$ knife bootstrap 10.128.236.128 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key --node-name mysqlinst 
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









OK, so log to your Chef workstation and go to your cookbooks directory. Create the wordpress cookbook.

Create the cookbook:

```shell
chef generate cookbook wordpress
```

When you go to your cookbook directory(wordpress in my case) and type ll, you can see smthng like this:

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

Our next step is to create the default attributes. These are the values that we can change and modify the behavior of the installed packages or change the usernames, passwords, directory locations etc.

```shell
cd wordpress
chef generate attribute default
```

[ATTRIBUTES](https://docs.chef.io/attributes.html)


Now, let’s move to the recipes. In order to install WordPress, we’ll have to install Apache web-server, install PHP and its modules so WordPress as a PHP program can run, then install MySQL database server and finally download WordPress and extract it under the Apache root directory that we specified in the default attributes. We’ll create a recipe for each of these steps.

## Apache recipe
Recipe:
A recipe consists of a series of resources which defines the state of a particular service or an application, for example, one resource could say “the NTP service should be running”, another may say “the telnet service should be stopped”

Create the recipe first. This will create a file apache.rb under the recipes directory.

```shell
chef generate recipe apache
```
To can find this recipe in this repository and investigate it))


Let's create default config file for the Apache web server and that the template for that is a file called httpd.conf.erb
So, let’s create that template. This command will create a directory called templates and a file httpd.conf.erb
```shell
chef generate template httpd.conf
```
lokking for this file in this repo))

## PHP
Same as with the Apache recipe, we’ll have to generate a recipe for PHP and it’s modules.

```shell
chef generate recipe php
```
Edit the newly created file php.rb and use next configuration

```ruby
# SPECIFY 5.6 PHP VERSION
execute 'specify_php_version' do
  command 'yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm'
  ignore_failure true
end

execute 'specify_php_version' do
  command 'yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm'
  ignore_failure true
end

execute 'specify_php_version' do
  command 'yum install yum-utils'
  ignore_failure true
end

execute 'specify_php_version' do
  command 'yum-config-manager --enable remi-php56 '
  ignore_failure true
end


%w{php php-fpm php-mysql php-xmlrpc php-gd php-pear php-pspell}.each do |pkg|
  package pkg do
    action :install
    notifies :reload, 'service[httpd]', :immediately
  end
end
```
![image](https://user-images.githubusercontent.com/30426958/58631014-d855c000-82e9-11e9-985b-d6119baf318d.png)
ATTTENTION: The newest version of wordpress ( by 29.05.2019 ) require at least 5.6.20 version of PHP. Therefore, you has 2 ways!:
* Set up Wordpress 5.1.x version, which support php5.4
* Set up php5.6 by adding remi repository and installing php from there.

I am choose second way, therefore you can find some bash commands in php.rb with names 'specify_php_version'





## Running Chef client as a daemon    [tip](https://subscription.packtpub.com/book/networking_and_servers/9781785287947/1/ch01lvl1sec25/running-chef-client-as-a-daemon)

While you can run the Chef client on your nodes manually whenever you change something in your Chef repository, it's sometimes preferable to have the Chef client run automatically every so often. Letting the Chef client run automatically makes sure that no box misses out any updates

```shell
user@server:~$ subl /etc/cron.d/chef_client
```

```shell
PATH=/usr/local/bin:/usr/bin:/bin
# m h dom mon dow user command
*/15 * * * * root chef-client -l warn | grep -v 'retrying [1234]/5 in'\
```
