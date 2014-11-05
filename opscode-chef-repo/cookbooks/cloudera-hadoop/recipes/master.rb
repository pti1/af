# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


service "hadoop-hdfs-namenode" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

service "hadoop-hdfs-datanode" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

service "hadoop-yarn-resourcemanager" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end


service "hadoop-yarn-nodemanager" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end




bash "format namenode" do
  action :run
#  creates "/opt/hdfs-formatted-#{node['fqdn']}"
  user "root"
  cwd "/tmp"
  code <<-EOH
mkdir -p /mnt/ext/hadoop/hdfs/namenode
chmod -R 777 /mnt/ext/hadoop/hdfs/namenode
sleep 1
su -c "hdfs namenode -format" hdfs > /opt/hdfs-formatted-#{node['fqdn']}
  EOH
  notifies :stop, "service[hadoop-hdfs-namenode]", :immediately
  notifies :stop, "service[hadoop-hdfs-datanode]", :immediately

  not_if { ::File.exists?("/opt/hdfs-formatted-#{node['fqdn']}") }
end



template "/etc/hadoop/conf.empty/core-site.xml" do
  source 'core-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => node['fqdn']
  )

  notifies :restart, "service[hadoop-hdfs-namenode]", :delayed
  notifies :restart, "service[hadoop-hdfs-datanode]", :delayed
end

template "/etc/hadoop/conf.empty/yarn-site.xml" do
  source 'yarn-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => node['fqdn']
  )
  notifies :restart, "service[hadoop-yarn-resourcemanager]", :delayed
  notifies :restart, "service[hadoop-yarn-nodemanager]", :delayed
end

clusternodes = search(:node, "role:*-cloudera AND chef_environment:#{node.chef_environment}")
repliFactor = [clusternodes.length,2].min


template "/etc/hadoop/conf.empty/hdfs-site.xml" do
  source 'hdfs-site.erb'
  mode '777'
  owner 'root'
  variables(
    :replicationfactor => repliFactor,
    :blocksize => node[:hdfs][:blocksize]
  )
  notifies :restart, "service[hadoop-yarn-resourcemanager]", :delayed
  notifies :restart, "service[hadoop-yarn-nodemanager]", :delayed
end

cookbook_file "/etc/hadoop/conf.empty/mapred-site.xml" do
 source 'mapred-site.xml'
 mode '777'
 owner 'root'
end

service "hadoop-hdfs-namenode" do
  action :start
end


service "hadoop-hdfs-datanode" do
  action :start
end

service "hadoop-yarn-resourcemanager" do
  action :start
end


service "hadoop-yarn-nodemanager" do
  action :start
end

# now configuration
user "pascal" do
  supports :manage_home => true
  comment "pascal User"
  home "/home/pascal"
  shell "/bin/bash"
end

bash "create hdfs directories" do
  action :run
  user "root"
  cwd "/tmp"
  code <<-EOH
touch /opt/hdfs-directories-#{node['fqdn']}
su -c "hadoop fs -rm -r /tmp" hdfs
su -c "hadoop fs -mkdir -p /tmp/hadoop-yarn/staging" hdfs
su -c "hadoop fs -chmod -R 777 /tmp/hadoop-yarn/staging" hdfs
su -c "hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate" hdfs
su -c "hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging" hdfs
su -c "hadoop fs -mkdir -p /var/log/hadoop-yarn" hdfs
su -c "hadoop fs -chown yarn:mapred /var/log/hadoop-yarn" hdfs
su -c "hadoop fs -mkdir -p /user/root" hdfs
su -c "hadoop fs -chown root:root /user/root" hdfs
su -c "hadoop fs -mkdir -p /user/pascal" hdfs
su -c "hadoop fs -chown pascal:pascal /user/pascal" hdfs
su -c "hadoop fs -chmod -R 1777 /tmp" hdfs
EOH

  # need hdfs to be up
  only_if `netstat -taupn | grep 8020 | wc -l` == 3
  not_if { ::File.exists?("/opt/hdfs-directories-#{node['fqdn']}") }
end



