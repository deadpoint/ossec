require 'spec_helper'

describe 'ossec::config::alerts' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'alerts' }

  let (:params) { { :email_alert_level => '6', :log_alert_level => '6', :use_geoip => 'yes', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::alerts is for setting ossec server options only/)
    end
  end

  context 'email alert level  not set properly' do
    let (:params) { { :email_alert_level => '0', :log_alert_level => '6', :use_geoip => 'yes', :name => "#{title}" } }

    it 'should complain about email alert level being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid email_alert_level, \[#{params[:email_alert_level]}\] must be 1-16/)
    end
  end

  context 'log alert level  not set properly' do
    let (:params) { { :email_alert_level => '6', :log_alert_level => '17', :use_geoip => 'yes', :name => "#{title}" } }

    it 'should complain about log alert level being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid log_alert_level, \[#{params[:log_alert_level]}\] must be 1-16/)
    end
  end

  it 'should contain a concat::fragment for setting the alerts options' do
    should contain_concat__fragment("ossec_alerts").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '06',
      'content' => "  <alerts>\n    <email_alert_level>#{params[:email_alert_level]}</email_alert_level>\n    <log_alert_level>#{params[:log_alert_level]}</log_alert_level>\n    <use_geoip>#{params[:use_geoip]}</use_geoip>\n  </alerts>\n\n",
  })

  end
end

