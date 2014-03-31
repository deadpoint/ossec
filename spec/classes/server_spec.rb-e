require 'spec_helper'

describe 'ossec::server' do

  let :facts do {
    :concat_basedir => '/foo',
  }
  end

  let :pre_condition do
    'include ossec::params'
  end

  let (:params) { { :enable_db => false, :enable_debug => false, :enable_agentless => false, :enable_csyslog => false } }

  let (:ossec_params_server_package_name) { 'ossec-hids-server' }

  let (:ossec_params_plist_file) { '/var/ossec/bin/.process_list' }

  let (:ossec_params_user) { 'ossec' }

  let (:ossec_params_group) { 'ossec' }

  let (:ossec_params_client_keys) { '/var/ossec/etc/client.keys' }

  it 'should contain concat::setup' do
    should contain_concat__setup
  end

  it 'should contain ossec::service' do
    should contain_ossec__service
  end

  it 'should contain ossec::config with install_type set to server' do
    should contain_ossec__config.with({
      'install_type' => 'server'
    })
  end

  it 'should contain ossec::config::remote' do
    should contain_ossec__config__remote
  end

  it 'should contain ossec::config::global' do
    should contain_ossec__config__global
  end

  it 'should have the ossec server package installed' do
    should contain_package('ossec').with({
      'name'   => "#{ossec_params_server_package_name}",
      'ensure' => 'installed',
    })
  end

  it 'should manage the plist_file' do
    should contain_file('pfile').with({
      'path'    => "#{ossec_params_plist_file}",
      'ensure'  => 'file',
      'owner'   => "#{ossec_params_user}",
      'group'   => "#{ossec_params_group}",
      'mode'    => '0644',
      'require' => 'Package[ossec]',
      'notify'  => 'Class[Ossec::Service]',
    })
  end

  it 'should contain a concat for managing the client keys' do
    should contain_concat("#{ossec_params_client_keys}").with({
      'owner'   => 'root',
      'group'   => "#{ossec_params_group}",
      'mode'    => '0440',
      'require' => 'Package[ossec]',
      'notify'  => 'Class[Ossec::Service]',
  })
  end
end
