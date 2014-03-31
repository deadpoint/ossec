require 'spec_helper'

describe 'ossec::config::localfile' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { '/foo/messages' }

  let (:params) { { :frequency => '1234', :log_format => 'syslog', :command => 'command-name', :ossec_alias => 'command-alias', :check_diff => false, :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'log_format not set properly' do
    let (:params) { { :frequency => '1234', :log_format => 'blah', :command => 'command-name', :ossec_alias => 'command-alias', :check_diff => false, :name => "#{title}" } }

    it 'should complain about log_format being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid log_format, \[#{params[:log_format]}\], must be one of the following values: syslog,snort-full,snort-fast,squid,iis,eventlog,mysql_log,postgresql_log,nmapg,apache,command,full_command,djb-multilog,multi-line/)
    end
  end

  it 'should contain a concat::fragment for setting the activeres options' do
    should contain_concat__fragment("ossec_localfile_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '15',
      'content' => "  <localfile>\n    <log_format>#{params[:log_format]}</log_format>\n    <location>#{params[:name]}</location>\n  </localfile>\n\n",
  })

  end
end

