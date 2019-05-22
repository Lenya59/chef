#  install and enable Remi repository
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm


# disable the installation of php5.4 using yum-config-manager command provided by yum-utils tool

yum install yum-utils
yum-config-manager --disable remi-php54
yum-config-manager --enable remi-php73

# Installing LAMP Stack on CentOS 7
yum install httpd mariadb mariadb-server php php-common php-mysql php-gd php-xml php-mbstring php-mcrypt
