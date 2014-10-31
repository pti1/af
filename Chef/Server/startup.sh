#!/usr/bin/env bash


 
ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "chef serveur ui: https://$ipaddress"
echo "user is pascal, pwd is pascal"

sysctl -w kernel.shmmax=17179869184 # for postgres
/opt/chef-server/embedded/bin/runsvdir-start &


# reconfigure
cat << EOF > /etc/chef-server/chef-server.rb
server_name = "chefserver"
api_fqdn server_name

nginx['url'] = "https://#{server_name}"
nginx['server_name'] = server_name
lb['fqdn'] = server_name
bookshelf['vip'] = server_name
EOF

chef-server-ctl reconfigure

#now configure knife
yes rootpwd | knife configure -i -y --defaults -r /chef-repo -u rooty
knife user create pascal -p pascal -a -d

knife configure client /etc/chef

# load all
cd /chef-repo
knife environment from file environments/*.rb
knife cookbook upload -a
knife role from file roles/*.rb


chef-client -d -i 120 -s 5 -c /etc/chef/client.rb

ipaddress=`ifconfig eth0 | perl -n -e 'if (m/inet addr:([\d\.]+)/g) { print $1 }'`
echo "chef serveur ui: https://$ipaddress"
echo "user is pascal, pwd is pascal"



/usr/sbin/sshd -D




