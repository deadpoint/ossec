require 'net/ssh'

ssh_server = ENV['PORT_22'] || 2200
ssh_client = ENV['PORT_22_B'] || 2201

Given /^a system has been initialized$/ do
  # This step doesn't do anything.  It exists just to make the story read better.
end

#login with password as vagrant
When /^I can ssh to the server as "(.*?)"$/ do | username |
  lambda { @connection = Net::SSH.start("localhost", username, :port => ssh_server ,  :password => "vagrant") }.should_not raise_error
end

When /^I can ssh to the client as "(.*?)"$/ do | username |
  lambda { @connection = Net::SSH.start("localhost", username, :port => ssh_client ,  :password => "vagrant") }.should_not raise_error
end

Then /^I should see the common "(.*?)" services are "(.*?)"$/ do |service, status|
  sleep(60)
  res = @connection.exec!("/usr/bin/sudo /sbin/service \'#{service}\' status")
  res.should =~ /ossec-logcollector is #{status}/
  res.should =~ /ossec-syscheckd is #{status}/
  res.should =~ /ossec-execd is #{status}/
end

Then /^I should see the "(.*?)" server services are "(.*?)"$/ do |service, status|
  res = @connection.exec!("/usr/bin/sudo /sbin/service \'#{service}\' status")
  res.should =~ /ossec-monitord is #{status}/
  res.should =~ /ossec-remoted is #{status}/
  res.should =~ /ossec-analysisd is #{status}/
  res.should =~ /ossec-maild is #{status}/
end

Then /^I should see a server configuration file located at "(.*?)"$/ do |conf_file|
  res = @connection.exec!("/usr/bin/sudo /bin/cat #{conf_file}")
  res.should =~ /<global>/
  res.should =~ /<syscheck>/
  res.should =~ /<rules>/
  res.should =~ /<remote>/
  res.should =~ /<rootcheck>/
end

Then /^I should see the client "(.*?)" connected with an "(.*?)" status$/ do |hostname, status|
  res = @connection.exec!("/usr/bin/sudo /var/ossec/bin/agent_control -l")
  res.should =~ /ID:(.*?)#{hostname}(.*?)#{status}/
end

Then /^I should see the "(.*?)" client service is "(.*?)"$/ do |service, status|
  res = @connection.exec!("/usr/bin/sudo /sbin/service \'#{service}\' status")
  res.should =~ /ossec-agentd is #{status}/
end

Then /^I should see a client configuration file located at "(.*?)"$/ do |conf_file|
  res = @connection.exec!("/usr/bin/sudo /bin/cat #{conf_file}")
  res.should =~ /<client>/
  res.should =~ /<server-ip>/
end
