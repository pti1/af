# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "ganglia-monitor"


service "ganglia-monitor" do
  action :nothing
end

#gangliaserver = search(:node,"run_list:*ganglia-server*")
nodeinenv = search(:node,"chef_environment:#{node.chef_environment}")
nodeinenv.sort!{ |a, b| a.name <=> b.name}

electednode=nodeinenv[0]

template "/etc/ganglia/gmond.conf" do
    source 'gmond.erb'
    mode '777'
    owner 'root'
    variables(
      :env => node.chef_environment,
      :clustergmond => electednode.name
    )

    notifies :restart, "service[ganglia-monitor]", :delayed
 
end

service "ganglia-monitor" do
  action :start
end


