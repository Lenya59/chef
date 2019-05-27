# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "okuli"
client_key               "#{current_dir}/okuli.pem"
chef_server_url          "https://api.chef.io/organizations/okuli"
cookbook_path            ["#{current_dir}/../cookbooks"]



# current_dir = File.dirname(__FILE__)
# log_level                :info
# log_location             STDOUT
# node_name                'okuli'
# client_key               "#{current_dir}/okuli.pem"
# validation_client_name   'okuli-validator'
# validation_key           "#{current_dir}/okuli-validator.pem"
# chef_server_url          'https://manage.chef.io/organizations/okuli'
# cookbook_path [ '~/chef/cookbooks' ]
