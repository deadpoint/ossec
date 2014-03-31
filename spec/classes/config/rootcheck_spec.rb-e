require 'spec_helper'

describe 'ossec::config::rootcheck' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'rootcheck' }

  let (:params) { { :base_directory => '', :rootkit_files => '/etc/shared/rootkit_files.txt', :rootkit_trojans => '/etc/shared/rootkit_trojans.txt', :windows_audit => '', :system_audit => '', :windows_apps => '', :windows_malware => '', :scanall => 'no', :frequency => '36000', :disabled => 'no', :check_dev => 'yes', :check_files => 'yes', :check_if => 'yes', :check_pids => 'yes', :check_policy => 'yes', :check_ports => 'yes', :check_sys => 'yes', :check_trojans => 'yes', :check_unixaudit => 'yes', :check_winapps => 'yes', :check_winaudit => '1', :check_winmalware => 'yes', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  it 'should contain a concat::fragment for setting the agentless options' do
    should contain_concat__fragment("ossec_rootcheck").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '65',
      'content' => "  <rootcheck>\n    <base_directory>#{params[:base_directory]}</base_directory>\n    <rootkit_files>#{params[:rootkit_files]}</rootkit_files>\n    <rootkit_trojans>#{params[:rootkit_trojans]}</rootkit_trojans>\n    <windows_audit>#{params[:windows_audit]}</windows_audit>\n    <system_audit>#{params[:system_audit]}</system_audit>\n    <windows_apps>#{params[:windows_app]}</windows_apps>\n    <windows_malware>#{params[:windows_malware]}</windows_malware>\n    <scanall>#{params[:scanall]}</scanall>\n    <frequency>#{params[:frequency]}</frequency>\n    <disabled>#{params[:disabled]}</disabled>\n    <check_dev>#{params[:check_dev]}</check_dev>\n    <check_files>#{params[:check_files]}</check_files>\n    <check_if>#{params[:check_if]}</check_if>\n    <check_pids>#{params[:check_pids]}</check_pids>\n    <check_policy>#{params[:check_policy]}</check_policy>\n    <check_ports>#{params[:check_ports]}</check_ports>\n    <check_sys>#{params[:check_sys]}</check_sys>\n    <check_trojans>#{params[:check_trojans]}</check_trojans>\n    <check_unixaudit>#{params[:check_unixaudit]}</check_unixaudit>\n    <check_winapps>#{params[:check_winapps]}</check_winapps>\n    <check_winaudit>#{params[:check_winaudit]}</check_winaudit>\n    <check_winmalware>#{params[:check_winmalware]}</check_winmalware>\n  </rootcheck>\n\n",
  })

  end
end

