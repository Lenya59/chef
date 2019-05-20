# CHEF

  Hi to all. This repository will tell you about chef as such tasty configuration manager for controling your infrastructure. For a little bit more information looking for a link beside     [CHEF](https://docs.chef.io/chef_overview.html "Cheff Overview")
  
Main task you can find at this repo in a file with the same name. 

  Okay let's start. As the chef server we will use hosted chef organizaation. For building nodes infrastructure I will use virtualbox with the superstructure of the vagrant. You can find Vargantfile in this repo which will describe nodes properties. Althought don't forget that every node should bootstrap Cheff Client.
  
  
  
  
  
  First of all need to install chefDK to your machine. Install ChefDK (https://docs.chef.io/dk_windows.html "Cheff for Windows")
  
  
  we should bootstrap our nodes to hosted chef serve. But you should realize that you can connet to your machine, in my case it looks like:
  ```shell
  ssh -i /c/Users/okuli/chef/.vagrant/machines/awpinst/virtualbox/private_key -l vagrant -p 2222 localhost
  ```
  
