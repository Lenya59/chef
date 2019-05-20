#!/bin/bash

# BEGIN ########################################################################
echo -e "-- ------------------ --\n"
echo -e "-- BEGIN BOOTSTRAPING --\n"
echo -e "-- ------------------ --\n"

sudo yum update -y
sudo yum install -y bind-utils git mc htop mtr wget


# chef client install
curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 14.4.56
