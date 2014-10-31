#!/usr/bin/ruby


def updatehostfile

  hosts = File.readlines("/tmp/host.list")
  hosts = hosts.map {|s| s.gsub(/\n/, '')}
  puts hosts
  loopnb=0
  loopmax=10
  domain="example.com"
  continue = true
  ips = Array.new



  while(continue)
    ips = Array.new

    hosts.each{|aHost|
      ipo = `ping -c 1 -w 1 #{aHost}`
      ipo = ipo.grep(/PING/)

      if (ipo.length == 1) then
        ip = ipo[0]
        ip = ip.gsub(/.*\((.*)\).*/,'\1').gsub(/\n/,'')
        puts ip
        ips.push(ip)
      end

      if (hosts.length == ips.length) then
        puts "all resolved"
        continue = false
      end
    
     loopnb += 1

     if (loopnb>loopmax) then
       puts "hosts are not known"
       continue = false
       exit
     end
    }

  end

  puts "now updating host file: #{ips.inspect}" 

  trails = <<-eos
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
127.0.0.1       localhost
::1     localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
eos

   hostpart=""
   hosts.zip(ips).each do |host, ip|
     hostpart += "#{ip} #{host}.#{domain} #{host}\n"
   end

   hostpart+=trails

   `echo "#{hostpart}" > /etc/hosts`

end

updatehostfile
