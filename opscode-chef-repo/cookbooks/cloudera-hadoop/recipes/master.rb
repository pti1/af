#
# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/etc/hadoop/conf.empty/core-site.xml" do
  source 'core-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => node['fqdn']
  )
end

template "/etc/hadoop/conf.empty/yarn-site.xml" do
  source 'yarn-site.erb'
  mode '777'
  owner 'root'
  variables(
    :hadoopmasterfqdn => node['fqdn']
  )
end

cookbook_file "/etc/hadoop/conf.empty/mapred-site.xml" do
 source 'mapred-site.xml'
 mode '777'
 owner 'root'
end

#RUN su -c "hdfs namenode -format" hdfs  
