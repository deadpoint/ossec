require 'spec_helper'

describe 'ossec::config::command' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { 'host-deny' }

  let (:params) { { :executable => 'host-deny.sh', :expect => 'srcip', :timeout_allowed => 'yes', :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  context 'timeout_allowed not set properly' do
    let (:params) { { :executable => 'host-deny.sh', :expect => 'srcip', :timeout_allowed => 'blah', :name => "#{title}" } }

    it 'should complain about timeout_allowed being set incorrectly' do
      expect{ should compile }.to raise_error(Puppet::Error, /Invalid timeout_allowed, \[#{params[:timeout_allowed]}\], must be one of the following values: yes or no/)
    end
  end

  it 'should contain a concat::fragment for setting the activeres options' do
    should contain_concat__fragment("ossec_command_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '50',
      'content' => "  <command>\n    <name>#{params[:name]}</name>\n    <executable>#{params[:executable]}</executable>\n    <expect>#{params[:expect]}</expect>\n    <timeout_allowed>#{params[:timeout_allowed]}</timeout_allowed>\n  </command>\n\n",
  })

  end
end
