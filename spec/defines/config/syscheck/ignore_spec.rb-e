require 'spec_helper'

describe 'ossec::config::syscheck::ignore' do

  let :pre_condition do
    'include ossec::params'
  end

  let (:title) { '/var/foo' }

  let (:params) { { :name => "#{title}" } }

  let (:ossec_params_conf_file) { '/var/ossec/etc/ossec.conf' }

  it 'should contain a concat::fragment for setting the syscheck ignore options' do
    should contain_concat__fragment("syscheck_ignore_#{params[:name]}").with({
      'ensure'  => 'present',
      'target'  => "#{ossec_params_conf_file}",
      'order'   => '17',
      'content' => "  <syscheck>\n    <ignore>#{params[:name]}</ignore>\n  </syscheck>\n\n",
  })

  end
end

