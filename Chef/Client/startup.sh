#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "chef serveur ui: https://$ipaddress"
echo "user is pascal, pwd is pascal"


mkdir -p /root/.chef

cat << EOF > /root/.chef/knife.rb
log_level                :info
log_location             STDOUT
node_name                'chef-webui'
client_key               '/etc/chef-server/chef-webui.pem'
validation_client_name   'chef-validator'
validation_key           '/etc/chef-server/chef-validator.pem'
chef_server_url          'https://chefserver:443'
syntax_check_cache_path  '/root/.chef/syntax_check_cache'
cookbook_path [ '/chef-repo/cookbooks' ]
EOF

cp /etc/chef-server/chef-webui.pem /root/.chef/chef-webui.pem

knife configure client /etc/chef

chef-client -d -i 120 -s 5 -c /etc/chef/client.rb


/usr/sbin/sshd -D




