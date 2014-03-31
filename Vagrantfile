hostname = 'ossec-server.acme.com'

Vagrant.configure('2') do |config|

  config.vm.define :ossec_server do |config|
    config.vm.box = 'CentOS-6.4'
    config.vm.host_name = "ossec-server.acme.com"
	config.vm.provider :virtualbox do |vb|
	  vb.customize [ 'modifyvm', :id, '--memory', ENV['DEFAULT_VM_SIZE'] || 2048 ]
	  vb.customize [ 'modifyvm', :id, '--natdnsproxy1', 'off' ]
	  vb.customize [ 'modifyvm', :id, '--natdnshostresolver1', 'off' ]
	end
    config.vm.network :forwarded_port, :guest => 22, :host => ENV['PORT_22'] ? ENV['PORT_22'].to_i : 2200
    config.vm.network "private_network", ip: "192.168.50.10"
    config.vm.synced_folder 'vagrant/hiera', '/var/lib/hiera'
    config.vm.provision :puppet do |puppet|
      puppet.module_path = 'vagrant/modules'
      puppet.manifests_path = 'vagrant/manifests'
      puppet.manifest_file  = "ossec-server.pp"
      puppet.options = "--verbose --debug"
    end
  end

  config.vm.define :ossec_client do |config|
    config.vm.box = 'CentOS-6.4'
    config.vm.host_name = "ossec-client.acme.com"
  config.vm.provider :virtualbox do |vb|
    vb.customize [ 'modifyvm', :id, '--memory', ENV['DEFAULT_VM_SIZE'] || 2048 ]
    vb.customize [ 'modifyvm', :id, '--natdnsproxy1', 'off' ]
    vb.customize [ 'modifyvm', :id, '--natdnshostresolver1', 'off' ]
  end
    config.vm.network :forwarded_port, :guest => 22, :host => ENV['PORT_22_B'] ? ENV['PORT_22_B'].to_i : 2201
    config.vm.network "private_network", ip: "192.168.50.20"
    config.vm.synced_folder 'vagrant/hiera', '/var/lib/hiera'
    config.vm.provision :puppet do |puppet|
      puppet.module_path = 'vagrant/modules'
      puppet.manifests_path = 'vagrant/manifests'
      puppet.manifest_file  = "ossec-client.pp"
      puppet.options = "--verbose --debug"
    end
  end

end
