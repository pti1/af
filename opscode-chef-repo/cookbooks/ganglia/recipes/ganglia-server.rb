# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart

service "ganglia-monitor" do
  action :nothing
end

service "gmetad" do
  action :nothing
end

service "apache2" do
  action :nothing
end


gmonds = ""
environments = search(:environment, "name:*")


environments.sort! { |a, b| a.name <=> b.name }.each{|oneenv|

  #port=oneenv.name.to_i(36)
  port = 8649
  nodeinenv = search(:node,"chef_environment:#{oneenv.name}")

  if (nodeinenv.size == nil or nodeinenv.length == 0) 
  then
    next
  end

  gmonds += "data_source \"#{oneenv}\""

  nodeinenv.sort! { |a, b| a.fqdn <=> b.fqdn }.each{|onenode|
    gmonds += " #{onenode['fqdn']}:#{port}"
  }
 
  gmonds += "\n"   

}

Chef::Log.info("gmond conf : #{gmonds}")


template "/etc/ganglia/gmetad.conf" do
  source 'gmetad.erb'
  mode '777'
  owner 'root'
  variables(
    :gmonds => gmonds
  )

  notifies :restart, "service[ganglia-monitor]", :delayed
  notifies :restart, "service[gmetad]", :delayed
  notifies :restart, "service[apache2]", :delayed
end

service "ganglia-monitor" do
  action :start
end

service "gmetad" do
  action :start
end

service "apache2" do
  action :start
end



