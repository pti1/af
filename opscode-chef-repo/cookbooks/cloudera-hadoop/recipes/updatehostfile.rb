#
# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


bash "restart when hostfilechange" do
  action :nothing
  user "root"
  cwd "/tmp"
  code <<-EOH
service hadoop-hdfs-namenode restart
service hadoop-hdfs-datanode restart
EOH
end



clusternodes = search(:node, "role:*-cloudera AND chef_environment:#{node.chef_environment}")
clusternodes.sort! { |a, b| a.fqdn <=> b.fqdn }



  ruby_block "update /etc/hosts" do
    block do
clusternodes.each do |aNode|
  Chef::Log.info("#{aNode["fqdn"]} has IP address #{aNode["ipaddress"]}")

      fe = Chef::Util::FileEdit.new("/etc/hosts")
      fe.insert_line_if_no_match(/#{aNode["hostname"]}/,
                               "#{aNode["ipaddress"]} #{aNode["fqdn"]} #{aNode["hostname"]}")

      fe.search_file_replace_line(/#{aNode["hostname"]}/,
                               "#{aNode["ipaddress"]} #{aNode["fqdn"]} #{aNode["hostname"]}")

      fe.write_file
    end
end
    action :nothing
  end


template "/tmp/hosts" do
  source 'hosts.erb'
  mode '777'
  owner 'root'
  variables(
    :nodes => clusternodes
  )
  notifies :create, "ruby_block[update /etc/hosts]", :immediately
  notifies :run, "bash[restart when hostfilechange]", :delayed
end

