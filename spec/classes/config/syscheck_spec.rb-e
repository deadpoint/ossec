require 'spec_helper'

describe 'ossec::config::syscheck' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'syscheck' }

  let (:params) { { :frequency => '21600', :scan_time => '11pm', :scan_day => 'sunday', :auto_ignore => 'yes', :alert_new_files => 'no', :scan_on_start => 'yes', :windows_registry => 'HKEY_LOCAL_MACHINESoftware', :registry_ignore => '..CryptographyRNG', :prefilter_cmd => '/usr/bin/prelink -y', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'scan day not set properly' do
    let (:params) { { :frequency => '21600', :scan_time => '11pm', :scan_day => 'blah', :auto_ignore => 'yes', :alert_new_files => 'no', :scan_on_start => 'yes', :windows_registry => 'HKEY_LOCAL_MACHINESoftware', :registry_ignore => '..CryptographyRNG', :prefilter_cmd => '/usr/bin/prelink -y', :name => "#{title}" } }

    it 'should complain about scan day being set incorrectly' do
        expect{ should compile }.to raise_error(Puppet::Error, /Invalid scan_day, \[#{params[:scan_day]}\], must be sunday, monday, tuesday, etc/)
    end
  end

  it 'should contain a concat::fragment for setting the syscheck options' do
    should contain_concat__fragment("ossec_syscheck").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '11',
      'content' => "  <syscheck>\n    <frequency>#{params[:frequency]}</frequency>\n    <scan_time>#{params[:scan_time]}</scan_time>\n    <scan_day>#{params[:scan_day]}</scan_day>\n    <auto_ignore>#{params[:auto_ignore]}</auto_ignore>\n    <alert_new_files>#{params[:alert_new_files]}</alert_new_files>\n    <scan_on_start>#{params[:scan_on_start]}</scan_on_start>\n    <windows_registry>#{params[:windows_registry]}</windows_registry>\n    <registry_ignore>#{params[:registry_ignore]}</registry_ignore>\n    <prefilter_cmd>#{params[:prefilter_cmd]}</prefilter_cmd>\n  </syscheck>\n\n",
  })

  end
end

