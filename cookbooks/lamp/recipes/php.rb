#
# Cookbook:: lamp
# Recipe:: php
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# install php.
package "php" do
    action :install
end

package "php-common" do
  action :install
end

package "php-gd" do
  action :install
end

package "php-mbstring" do
  action :install
end

package "php-mcrypt" do
  action :install
end

#Install php-mysql.
package 'php-mysql' do
    action :install
    notifies :restart, "service[httpd]"
end
