# Cookbook Name:: cloudera-hadoop
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#apt_repository 'ganglia' do
#  uri        'http://ppa.launchpad.net/rufustfirefly/ganglia/ubuntu'
#  components ['main']
#  distribution 'precise'
#end


package "ganglia-monitor" do
  options "--force-yes"
end

service "ganglia-monitor" do
  action :nothing
end

#gangliaserver = search(:node,"run_list:*ganglia-server*")
nodeinenv = search(:node,"chef_environment:#{node.chef_environment}")
nodeinenv.sort!{ |a, b| a.name <=> b.name}

mastername = "notyet"
if nodeinenv.size > 0 then
  electednode=nodeinenv[0]
  mastername = electednode.name
end

template "/etc/ganglia/gmond.conf" do
    source 'gmond.erb'
    mode '777'
    owner 'root'
    variables(
      :env => node.chef_environment,
      :clustergmond => mastername
    )

    notifies :restart, "service[ganglia-monitor]", :delayed
 
end

service "ganglia-monitor" do
  action :start
end


