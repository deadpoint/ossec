require 'spec_helper'

describe 'ossec::clientkey' do

  let(:title) { 'ossec_key_foo.acme.com_server' }

  let (:params) { { :client_id => '001', :client_name => 'foo.acme.com', :client_ip => '192.168.20.10', :client_seed => '12345' } }

  it 'should include the params class' do
    should contain_class('ossec::params')
  end

  context 'missing client_seed' do
    let (:params) { { :client_id => '001', :client_name => 'foo.acme.com', :client_ip => '192.168.20.10' } }

    it 'should fail if the client_seed parameter is not set' do
      expect { should compile }.to raise_error(Puppet::Error, /Ossec::Clientkey parameter client_seed is not set!/)
    end
  end

  let (:key1) { Digest::MD5.hexdigest("#{params[:client_id]} #{params[:client_seed]}") }
  let (:key2) { Digest::MD5.hexdigest("#{params[:client_name]} #{params[:client_ip]} #{params[:client_seed]}") }
  let (:ossec_params_client_keys) { "/var/ossec/etc/client.keys" }

  it 'should define a client key resource that appends to an existing file' do
    should contain_concat__fragment("ossec-client-key-#{params[:client_ip]}").with({
        'ensure'  => 'present',
        'target'  => "#{ossec_params_client_keys}",
        'order'   => "#{params[:client_id]}",
        'content' => "#{params[:client_id]} #{params[:client_name]} #{params[:client_ip]} #{key1}#{key2}\n",
    })
  end
end

