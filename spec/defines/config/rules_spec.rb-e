require 'spec_helper'

describe 'ossec::config::rules' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'sshd_rules.xml' }

  let (:params) { { :order => 2, :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'name set to rules_config.xml' do
    let (:params) { { :order => 2, :name => "rules_config.xml" } }

    it 'should not allow you to add rules_config.xml as that is added by default' do
      expect{ should compile }.to raise_error(Puppet::Error, /Ossec rule \[#{params[:name]}\] is included by default, remove it from the manifest/)
    end
  end

  context 'install_type set to client' do
    let :facts do {
      :concat_basedir => '/foo'
    }
    end

    let :pre_condition do
      'include ossec::client'
    end

    it 'should complain if $ossec::config::install_type is set to client' do
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::rules is for setting ossec server options only/)
    end
  end

  let (:rule_num) { 2001 + params[:order] }

  it 'should contain a concat::fragment for setting the rules' do
    should contain_concat__fragment("ossec_rules_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => "#{rule_num}",
      'content' => "    <include>#{params[:name]}</include>\n",
  })
  end
end
