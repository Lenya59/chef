

#  Validate your connection to the Chef server.
knife ssl check

vagrant ssh-config

# Test ssh connection to awpinst using key-based authentication
ssh -i /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key vagrant@10.128.236.150
# bootstrap node awpinst
knife bootstrap 10.128.236.150 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --node-name awpinst


# Test ssh connection to mysqlinst
ssh -i /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key vagrant@10.128.236.232

# bootstrap node mysqlinst
knife bootstrap 10.128.236.232 --ssh-user vagrant --sudo --identity-file /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key --node-name mysqlinst



knife ssh localhost --ssh-port 2222 'sudo chef-client' --ssh-user vagrant --ssh-identity-file /c/Users/okuli/chef/.vagrant/machines/mysqlinst/virtualbox/private_key --manual-list


#You can add a cookbook to the run_list of a particular node using the following command.
#Replace awpinst with your client node name.
knife node run_list add awpinst apache



#To remove the particular recipe from run_list (optional)
knife node run_list remove awpinst recipe run_list: recipe[apache]


knife ssh 'name:awpinst' 'sudo chef-client' -x root



knife ssh localhost --ssh-port 2222 'sudo chef-client' --ssh-user vagrant --ssh-identity-file /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key --manual-list
knife ssh localhost --ssh-port 2222 'sudo chef-client' --ssh-user vagrant --ssh-identity-file IDENTITY_FILE --manual-list
