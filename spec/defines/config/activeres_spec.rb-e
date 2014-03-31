require 'spec_helper'

describe 'ossec::config::activeres' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'command-name' }

  let (:params) { { :disabled => false, :command => 'foo', :location => 'local', :level => '6', :timeout => '600', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::activeres is for setting ossec server options only/)
    end
  end

  context 'location not set properly' do
    let (:params) { { :disabled => false, :command => 'foo', :location => 'blah', :level => '6', :timeout => '600', :name => "#{title}" } }

    it 'should complain about location being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid location, \[#{params[:location]}\], must be one of the following values: local, server, defined-agent, or all/)
    end
  end

  it 'should contain a concat::fragment for setting the activeres options' do
    should contain_concat__fragment("ossec_activeres_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '55',
      'content' => "  <active-response>\n    <command>#{params[:command]}</command>\n    <location>#{params[:location]}</location>\n    <level>#{params[:level]}</level>\n    <timeout>#{params[:timeout]}</timeout>\n  </active-response>\n\n",
  })

  end
end
