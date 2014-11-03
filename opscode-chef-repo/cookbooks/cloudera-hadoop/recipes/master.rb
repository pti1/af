#
# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

service "hadoop-hdfs-datanode" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end


service "hadoop-hdfs-namenode" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end

service "hadoop-yarn-nodemanager" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end


service "hadoop-yarn-resourcemanager" do
  supports :restart => true, :start => true, :stop => true
  action :nothing
end


bash "format namenode" do
  action :run
  creates "/opt/hdfs-formatted-#{node['fqdn']}"
  user "root"
  cwd "/tmp"
  code <<-EOH
su -c "hdfs namenode -format" hdfs > /opt/hdfs-formatted-#{node['fqdn']}
  EOH
  notifies :stop, "service[hadoop-hdfs-namenode]", :immediately
  notifies :stop, "service[hadoop-hdfs-datanode]", :immediately

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

cookbook_file "/etc/hadoop/conf.empty/mapred-site.xml" do
 source 'mapred-site.xml'
 mode '777'
 owner 'root'
end

service "hadoop-hdfs-datanode" do
  action :start
end


service "hadoop-hdfs-namenode" do
  action :start
end

service "hadoop-yarn-nodemanager" do
  action :start
end


service "hadoop-yarn-resourcemanager" do
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
  creates "/opt/hdfs-directories-#{node['fqdn']}"
  user "hdfs"
  cwd "/tmp"
  code <<-EOH
hadoop fs -rm -r /tmp
hadoop fs -chmod -R 1777 /tmp
hadoop fs -mkdir /tmp/hadoop-yarn/staging
hadoop fs -chmod -R 777 /tmp/hadoop-yarn/staging
hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate
hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging
hadoop fs -mkdir -p /var/log/hadoop-yarn
hadoop fs -chown yarn:mapred /var/log/hadoop-yarn
hadoop fs -mkdir -p /user/root
hadoop fs -chown root:root /user/root
hadoop fs -mkdir -p /user/pascal
hadoop fs -chown pascal:pascal /user/pascal
  EOH

  # need hdfs to be up
  only_if "hadoop fs -ls /"
end



