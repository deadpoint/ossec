require 'spec_helper'

describe 'ossec::service' do

  let :pre_condition do
    'include ossec::params'
  end

  let(:ossec_params_service_name) { 'ossec-hids' }

  it 'should include the class ossec::params' do
    should contain_ossec__params
  end

  it 'should define the ossec service' do
    should contain_service('ossec').with({
        'name'        => "#{ossec_params_service_name}",
        'enable'      => 'true',
        'ensure'      => 'running',
        'hasrestart'  => 'true',
        'hasstatus'   => 'true',
        'require'     => 'Package[ossec]',
    })
  end
end

