require 'spec_helper'

describe 'ossec::config::client' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'client' }

  let (:params) { { :server_ip => '10.10.10.10', :server_hostname => 'ossec.acme.com', :server_port => '1514', :notify_time => '600', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'install_type set to server' do
    let :facts do {
      :concat_basedir => '/foo'
    }
    end

    let :pre_condition do
      'include ossec::server'
    end

    it 'should complain if $ossec::config::install_type is set to server' do
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::client is for setting ossec client options only/)
    end
  end

  context 'either server_ip or server_hostname must be defined' do
    let (:params) { { :server_ip => '', :server_hostname => '', :server_port => '1514', :notify_time => '600', :name => "#{title}" } }

    it 'should complain if the server_ip and the server hostname are missing' do
      expect{ should compile }.to raise_error(Puppet::Error, /Either server_ip or server_hostname must be set/)
    end
  end

  it 'should contain a concat::fragment for setting the client options' do
    should contain_concat__fragment("ossec_client").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '05',
      'content' => "    <client>\n        <server-ip>#{params[:server_ip]}</server-ip>\n        <server-hostname>#{params[:server_hostname]}</server-hostname>\n        <server-port>#{params[:server_port]}</server-port>\n        <notify-time>#{params[:notify_time]}</notify-time>\n    </client>\n",
  })

  end
end

