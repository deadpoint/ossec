require 'spec_helper'

describe 'ossec::config::database' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'database' }

  let (:params) { { :db_hostname => 'ossec', :db_user => 'foo', :db_password => 'bar', :database => 'ossec', :db_type => 'mysql', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::database is for setting ossec server options only/)
    end
  end

  context 'DB type not set properly' do
    let (:params) { { :db_hostname => 'ossec', :db_user => 'foo', :db_password => 'bar', :database => 'ossec', :db_type => 'blah', :name => "#{title}" } }

    it 'should complain about DB type being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid db_type, \[#{params[:db_type]}\] must be either mysql or postgresql/)
    end
  end

  it 'should contain a concat::fragment for setting the database options' do
    should contain_concat__fragment("ossec_database").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '08',
      'content' => "  <database_output>\n    <hostname>#{params[:db_hostname]}</hostname>\n    <user>#{params[:db_user]}</user>\n    <password>#{params[:db_password]}</password>\n    <database>#{params[:database]}</database>\n    <type>#{params[:db_type]}<type>\n  </database_output>\n\n",
  })

  end
end

