name "web_servers"
description "This role contains nodes, which act as web servers"
run_list "recipe[httpd]"
default_attributes 'ntp' => {
   'ntpdate' => {
      'disable' => true
   }
}
