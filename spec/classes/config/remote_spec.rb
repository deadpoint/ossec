require 'spec_helper'

describe 'ossec::config::remote' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'remote' }

  let (:params) { { :connection => 'secure', :port => '1514', :protocol => 'udp', :allowed_ips => '10.10.10.10', :deny_ips => '12.12.12.12', :local_ips => '10.10.10.12', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'install_type set to client' do
    let :facts do {
      :concat_basedir => '/foo'
    }
    end

    let :pre_condition do
      'include ossec::client'
    end

    it 'should complain if $ossec::config::install_type is set to client' do
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::remote is for setting ossec server options only/)
    end
  end

  it 'should contain a concat::fragment for setting the agentless options' do
    should contain_concat__fragment("ossec_remote").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '30',
      'content' => "  <remote>\n    <connection>#{params[:connection]}</connection>\n    <port>#{params[:port]}</port>\n    <protocol>#{params[:protocol]}</protocol>\n\n    <allowed-ips>#{params[:allowed_ips]}</allowed-ips>\n\n    <deny-ips>#{params[:deny_ips]}</deny-ips>\n\n    <local-ips>#{params[:local_ips]}</local-ips>\n  </remote>\n\n",
  })

  end
end

