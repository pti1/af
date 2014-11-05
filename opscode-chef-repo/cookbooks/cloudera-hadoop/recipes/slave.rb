# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

clustermasternodes = search(:node, "role:master-cloudera AND chef_environment:#{node.chef_environment}")
hadoopmaster = clustermasternodes[0]

service "hadoop-hdfs-datanode" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end


service "hadoop-yarn-nodemanager" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end




template "/etc/hadoop/conf.empty/core-site.xml" do
  source 'core-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => hadoopmaster['fqdn']
  )

  notifies :restart, "service[hadoop-hdfs-datanode]", :delayed
end

template "/etc/hadoop/conf.empty/yarn-site.xml" do
  source 'yarn-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => hadoopmaster['fqdn']
  )
  notifies :restart, "service[hadoop-yarn-nodemanager]", :delayed
end

cookbook_file "/etc/hadoop/conf.empty/mapred-site.xml" do
 source 'mapred-site.xml'
 mode '777'
 owner 'root'
end

service "hadoop-hdfs-datanode" do
  action :start
end

service "hadoop-yarn-nodemanager" do
  action :start
end


user "pascal" do
  supports :manage_home => true
  comment "pascal User"
  home "/home/pascal"
  shell "/bin/bash"
end


