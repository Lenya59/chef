#
# Cookbook:: lamp
# Recipe:: php
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# install php packeges
package "php" do
    action :install
end

package %w(php-common php-gd)  do
  action :install
end

package %w(php-xml php-mbstring)  do
  action :install
end

package %w(php-devel php-pecl-memcache)  do
  action :install
end

package %w(php-mysql php-pspell)  do
  action :install
end

package %w(php-snmp php-xmlrpc)  do
  action :install
end
