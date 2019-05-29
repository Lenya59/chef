#
# Cookbook:: wordpress
# Recipe:: php
#
# Copyright:: 2019, The Authors, All Rights Reserved.

# Install PHP and its modules

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
