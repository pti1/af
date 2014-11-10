# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#sudo service ganglia-monitor restart && sudo service gmetad restart && sudo service apache2 restart


service "gmetad" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  stop_command "kill `pidof gmetad`"
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

  gmondhost = ""
  if (nodeinenv.size == nil or nodeinenv.length == 0) 
  then
    #next
    gmondhost="na.example.com"
  else
    nodeinenv.sort!{ |a, b| a.name <=> b.name}
    electednode=nodeinenv[0]
    gmondhost = electednode.name
  end



  gmonds += "data_source \"#{oneenv}\" 30 #{gmondhost}:#{port}"
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

  notifies :stop, "service[gmetad]", :immediately

  notifies :restart, "service[apache2]", :delayed
end


service "gmetad" do
  action :start
end

service "apache2" do
  action :start
end



