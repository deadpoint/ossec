require 'spec_helper'

describe 'ossec::config::agentless' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'agentless' }

  let (:params) { { :frequency => '3600', :host => 'root@ossec.acme.com', :state => 'periodic', :arguments => '/bin /etc /sbin', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::agentless is for setting ossec server options only/)
    end
  end

  it 'should contain a concat::fragment for setting the agentless options' do
    should contain_concat__fragment("ossec_agentless").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '40',
      'content' => "  <agentless>\n    <frequency>#{params[:frequency]}</frequency>\n    <host>#{params[:host]}</host>\n    <state>#{params[:state]}</state>\n    <arguments>#{params[:arguments]}</arguments>\n  </agentless>\n\n",
  })

  end
end

