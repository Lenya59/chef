#
# Cookbook:: lamp
# Recipe:: apache
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package 'httpd' do
  action :install
end

service 'httpd' do
  action [ :enable, :start ]
end


cookbook_file "/var/www/html/index.html" do
  source "index.html"
  mode "0644"
end


execute 'firewalld_enable' do
  command 'sudo systemctl enable firewalld'
  ignore_failure true
end

execute 'firewalld_start' do
  command 'sudo systemctl start firewalld'
  ignore_failure true
end

execute 'httpd_firewall' do
  command '/usr/bin/firewall-cmd  --permanent --zone public --add-service http'
  ignore_failure true
end

execute 'reload_firewall' do
  command '/usr/bin/firewall-cmd --reload'
  ignore_failure true
end
