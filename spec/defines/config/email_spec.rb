require 'spec_helper'

describe 'ossec::config::email' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'syscheck@acme.com' }

  let (:params) { { :level => '15', :group => false, :event_location => 'agent007', :format => 'full', :rule_id => '5071', :do_not_delay => true, :do_not_group => true, :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::email is for setting ossec server options only/)
    end
  end

  context 'if format exists it should be set to full or sms' do
    let (:params) { { :level => '15', :group => false, :event_location => 'agent007', :format => 'blah', :rule_id => '5071', :do_not_delay => true, :do_not_group => true, :name => "#{title}" } }

    it 'should complain about format being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid format, \[#{params[:format]}\], must be one of the following values: full, sms/)
    end
  end

  it 'should contain a concat::fragment for setting the email options' do
    should contain_concat__fragment("ossec_email_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '07',
      'content' => "  <email_alerts>\n    <email_to>#{params[:name]}</email_to>\n    <level>#{params[:level]}</level>\n    <event_location>#{params[:event_location]}</event_location>\n    <format>#{params[:format]}</format>\n    <rule_id>#{params[:rule_id]}</rule_id>\n    <do_not_delay />\n    <do_not_group />\n  </email_alerts>\n\n",
  })
  end
end
