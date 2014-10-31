#
# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


clusternodes = search(:node, "role:hadoop* AND chef_environment:#{node.chef_environment}")

clusternodes.each do |node|
  Chef::Log.info("#{node["name"]} has IP address #{node["ipaddress"]}")

  ruby_block "ensure node can resolve API FQDN" do
    block do
      fe = Chef::Util::FileEdit.new("/etc/hosts")
      fe.insert_line_if_no_match(/#{node["name"]}/,
                               "#{node["ipaddress"]} #{node["name"]}")
      fe.write_file
    end
  end
end



