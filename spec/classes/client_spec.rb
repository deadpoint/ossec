require 'spec_helper'

describe 'ossec::client' do

  let :facts do {
    :concat_basedir => '/foo',
    :uniqueid       => '007F01',
    :fqdn           => 'ossec.acme.com'
  }
  end

  let :pre_condition do
    'include ossec::params'
  end

  let (:params) { { :client_ip => '10.10.10.10' } }

  let (:ossec_params_client_package_name) { 'ossec-hids-client' }

  let (:ossec_params_client_keys) { '/var/ossec/etc/client.keys' }

  let (:ossec_params_group) { 'ossec' }

  let (:ossec_params_client_seed) { 'YlusJIC4UBSaIIvu' }

  it 'should contain concat::setup' do
    should contain_concat__setup
  end

  it 'should contain ossec::service' do
    should contain_ossec__service
  end

  it 'should contain ossec::service with install_type set to client' do
    should contain_ossec__config.with({
      'install_type' => 'client'
    })
  end

  it 'should contain ossec::config::client' do
    should contain_ossec__config__client
  end

  it 'should contain the package ossec' do
    should contain_package('ossec').with({
      'ensure' => 'installed',
      'name'   => "#{ossec_params_client_package_name}",
    })
  end

  it 'should set client_keys' do
    should contain_concat("#{ossec_params_client_keys}").with({
      'owner'   => 'root',
      'group'   => "#{ossec_params_group}",
      'mode'    => '0440',
      'require' => 'Package[ossec]',
      'notify'  => 'Class[Ossec::Service]',
    })
  end

  it 'should set the key on the client' do
    should contain_ossec__clientkey("ossec_key_#{facts[:fqdn]}_client").with({
      'client_id'    => "#{facts[:uniqueid]}",
      'client_name'  => "#{facts[:fqdn]}",
      'client_ip'    => "#{params[:client_ip]}",
      'client_seed'  => "#{ossec_params_client_seed}"
    })
  end
end
