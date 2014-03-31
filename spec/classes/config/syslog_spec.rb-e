require 'spec_helper'

describe 'ossec::config::syslog' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'syslog' }

  let (:params) { { :server => '10.10.10.10', :port => '514', :level => '6', :group => 'syscheck', :rule_id => '5071', :location => '/var/foo', :format => 'default', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::syslog is for setting ossec server options only/)
    end
  end

  context 'format  not set properly' do
    let (:params) { { :server => '10.10.10.10', :port => '514', :level => '6', :group => 'syscheck', :rule_id => '5071', :location => '/var/foo', :format => 'blah', :name => "#{title}" } }

    it 'should complain about format being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid format, \[#{params[:format]}\], must be on of default, cef, json, or splunk/)
    end
  end

  context 'level  not set properly' do
    let (:params) { { :server => '10.10.10.10', :port => '514', :level => '0', :group => 'syscheck', :rule_id => '5071', :location => '/var/foo', :format => 'default', :name => "#{title}" } }

    it 'should complain about level being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid level, \[#{params[:level]}\], must be 1-16/)
    end
  end

  it 'should contain a concat::fragment for setting the syslog options' do
    should contain_concat__fragment("ossec_syslog").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '60',
      'content' => "  <syslog_output>\n    <server>#{params[:server]}</server>\n    <port>#{params[:port]}</port>\n    <level>#{params[:level]}</level>\n    <group>#{params[:group]}</group>\n    <rule_id>#{params[:rule_id]}</rule_id>\n    <location>#{params[:location]}</location>\n    <format>#{params[:format]}</format>\n  </syslog_output>\n\n",
  })

  end
end

