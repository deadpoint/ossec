require 'spec_helper'

describe 'ossec::config::reports' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'reports' }


  let (:params) { { :group => 'AV', :categories => 'AV', :rule => '5071', :level => '2', :location => 'ossec.bar.com', :srcip => '10.10.10.10', :user => 'foouser', :title => 'Report Title', :email_to => 'foo@bar.com', :showlogs => 'yes', :name => "#{title}" } }

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
      expect{ should compile }.to raise_error(Puppet::Error, /ossec::config::reports is for setting ossec server options only/)
    end
  end

  it 'should contain a concat::fragment for setting the agentless options' do
    should contain_concat__fragment("ossec_reports").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '45',
      'content' => "  <reports>\n    <group>#{params[:group]}</group>\n    <categories>#{params[:categories]}</categories>\n    <rule>#{params[:rule]}</rule>\n    <level>#{params[:level]}</level>\n    <location>#{params[:location]}</location>\n    <srcip>#{params[:srcip]}</srcip>\n    <user>#{params[:user]}</user>\n    <title>#{params[:title]}</title>\n    <email_to>#{params[:email_to]}</email_to>\n    <showlogs>#{params[:showlogs]}</showlogs>\n  </reports>\n\n",
  })

  end
end

